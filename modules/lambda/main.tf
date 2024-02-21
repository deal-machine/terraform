data "archive_file" "verse_api" {
  type        = "zip"
  source_file = "${local.functions_path}/api/index.mjs"
  output_path = "files/verse.zip"
}

resource "aws_cloudwatch_log_group" "log" {
  name              = "${var.prefix}/lambda/terraform/function"
  retention_in_days = 3
}

resource "aws_lambda_function" "lambda" {
  role             = var.role_arn
  function_name    = "verse"
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  filename         = data.archive_file.verse_api.output_path
  source_code_hash = data.archive_file.verse_api.output_base64sha256 # hash de alteração do arquivo zip
  description      = "Lambda function to get a bible verse"

  timeout     = 5
  memory_size = 128
  layers      = [aws_lambda_layer_version.got.arn]

  depends_on = [aws_cloudwatch_log_group.log]

  #x-ray
  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      URL = aws_ssm_parameter.bible_api.value
    }
  }

  tags = {
    Name = "${var.prefix}-lambda"
  }
}

# Atualização da permissão da função Lambda para ser invocada pela API Gateway
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.execution_arn}/*"
}

# Permissão para a função Lambda acessar o parâmetro SSM
resource "aws_lambda_permission" "ssm_permission" {
  action        = "lambda:InvokeFunction"
  statement_id  = "AllowExecutionFromLambda"
  function_name = aws_lambda_function.lambda.arn
  principal     = "ssm.amazonaws.com"
}

# layer
resource "null_resource" "install_deps" {
  # só aciona a trigger caso altere o arquivo de dependências
  triggers = {
    layer_build = filemd5("${local.layers_path}/got/nodejs/package.json")
  }

  provisioner "local-exec" {
    working_dir = "${local.layers_path}/got/nodejs"
    command     = "npm install --production"
  }
}

data "archive_file" "got_layer" {
  type        = "zip"
  source_dir  = "${local.layers_path}/got"
  output_path = "files/got.zip"
  depends_on  = [null_resource.install_deps]
}

resource "aws_lambda_layer_version" "got" {
  layer_name          = "got_layer"
  description         = "got: ^14.2.0"
  filename            = data.archive_file.got_layer.output_path
  source_code_hash    = data.archive_file.got_layer.output_base64sha256
  compatible_runtimes = ["nodejs18.x"]
}