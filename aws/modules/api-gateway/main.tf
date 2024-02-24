resource "aws_cloudwatch_log_group" "log" {
  name              = "${var.prefix}/api-gateway/terraform"
  retention_in_days = 3
}

resource "aws_apigatewayv2_api" "ag" {
  name          = "${var.prefix}-ag"
  protocol_type = "HTTP"
  description   = "API-Gateway"
  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    allow_headers = ["*"]
  }
  depends_on = [aws_cloudwatch_log_group.log]
}
resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.ag.id
  name        = "$default"
  description = "API-Gateway Stage"
  auto_deploy = true
}
resource "aws_apigatewayv2_integration" "integration" {
  api_id = aws_apigatewayv2_api.ag.id

  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  payload_format_version = "2.0"
  integration_uri        = var.invoke_arn
}
resource "aws_apigatewayv2_route" "route" {
  api_id             = aws_apigatewayv2_api.ag.id
  route_key          = "GET /bible"
  authorization_type = "NONE"
  target             = "integrations/${aws_apigatewayv2_integration.integration.id}"
}

# # Criação da API Gateway
# resource "aws_api_gateway_rest_api" "ag" {
#   name        = "${var.prefix}-ag"
#   description = "API-Gateway"
#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }
# # Criação do recurso na API Gateway
# resource "aws_api_gateway_resource" "endpoint" {
#   rest_api_id = aws_api_gateway_rest_api.ag.id
#   parent_id   = aws_api_gateway_rest_api.ag.root_resource_id
#   path_part   = "bible"
# }
# # Criação do método HTTP na API Gateway
# resource "aws_api_gateway_method" "method" {
#   rest_api_id   = aws_api_gateway_rest_api.ag.id
#   resource_id   = aws_api_gateway_resource.endpoint.id
#   http_method   = "POST"
#   authorization = "NONE"
# }
# resource "aws_api_gateway_method_response" "response" {
#   rest_api_id = aws_api_gateway_rest_api.ag.id
#   resource_id = aws_api_gateway_resource.endpoint.id
#   http_method = aws_api_gateway_method.method.http_method
#   status_code = "200"

#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Headers" = true,
#     "method.response.header.Access-Control-Allow-Methods" = true,
#     "method.response.header.Access-Control-Allow-Origin" = true
#   }
# }
# # Integração da função Lambda com o método HTTP na API Gateway
# resource "aws_api_gateway_integration" "integration" {
#   rest_api_id = aws_api_gateway_rest_api.ag.id
#   resource_id = aws_api_gateway_resource.endpoint.id
#   http_method = aws_api_gateway_method.method.http_method

#   integration_http_method = "POST"
#   type                    = "AWS"
#   uri                     = var.invoke_arn
# }
# resource "aws_api_gateway_integration_response" "integration_response" {
#   rest_api_id = aws_api_gateway_rest_api.ag.id
#   resource_id = aws_api_gateway_resource.endpoint.id
#   http_method = aws_api_gateway_method.method.http_method
#   status_code = aws_api_gateway_method_response.response.status_code

#   response_parameters = {
#       "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
#       "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
#       "method.response.header.Access-Control-Allow-Origin" = "'*'"
#   }

#   depends_on = [
#     aws_api_gateway_method.method,
#     aws_api_gateway_integration.integration
#   ]
# }
# # to activate the configuration and expose the API at a URL that can be used for testing
# resource "aws_api_gateway_deployment" "deployment" {
#   depends_on  = [aws_api_gateway_integration.integration]
#   rest_api_id = aws_api_gateway_rest_api.ag.id
#   stage_name  = "${var.prefix}-stage"
# }