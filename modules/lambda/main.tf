data "archive_file" "zip" {
    type        = "zip"
    source_dir  = "${path.module}/api"
    output_path = "${path.module}/terraform.zip" 
}

resource "aws_lambda_function" "lambda" {
    role = var.role_arn
    function_name = "terraform"
    runtime       = "nodejs18.x"
    handler       = "index.handler" #nomeDoArquivo.nomeDaFunção
    filename      = data.archive_file.zip.output_path
    source_code_hash = filebase64sha256(data.archive_file.zip.output_path) # hash de alteração do arquivo zip
    description = "Lambda function made with terraform"
    timeout = 5
    memory_size = 128
}