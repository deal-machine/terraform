output "api_url" {
  value = kubernetes_service.api_service.status
}
output "broker_url" {
  value = kubernetes_service.broker_service_cp.status
}