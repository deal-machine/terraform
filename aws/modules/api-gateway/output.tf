output "execution_arn" {
  value = aws_apigatewayv2_api.ag.execution_arn
}
output "uri" {
  value = aws_apigatewayv2_stage.stage.invoke_url
}