output "network_id" {
  value = google_compute_network.vpc.id
}
output "subnetwork_id" {
  value = google_compute_subnetwork.subnet.id
}

output "network_self_link" {
  value = google_compute_network.vpc.self_link
}
output "subnetwork_self_link" {
  value = google_compute_subnetwork.subnet.self_link
}