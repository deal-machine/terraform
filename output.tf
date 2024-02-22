output "api-gateway-uri" {
  value = module.api-gateway.uri
}
output "api-url" {
  value = module.k8s.api_url
}
output "broker_url" {
  value = module.k8s.broker_url
}