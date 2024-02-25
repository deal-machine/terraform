output "database_connection_info" {
  value     = module.sql.database_connection_info
  sensitive = true
}
output "cluster_endpoint" {
  value = module.gke.cluster_endpoint
}
output "cluster_ipv4_cidr" {
  value = module.gke.cluster_ipv4_cidr
}