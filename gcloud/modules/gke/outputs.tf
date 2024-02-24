
output "cluster_endpoint" {
  value = "https://${google_container_cluster.cluster.endpoint}"
}

output "cluster_auth" {
  value = data.google_client_config.provider.access_token
}
output "certificate" {
  value = google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
}