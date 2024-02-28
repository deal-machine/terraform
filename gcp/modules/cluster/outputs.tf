output "cluster_info" {
  value = {
    cluster_ca_certificate = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
    cluster_auth           = data.google_client_config.provider.access_token
    cluster_endpoint       = google_container_cluster.primary.endpoint
    sensitive              = false
  }
}