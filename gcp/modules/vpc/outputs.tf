output "network_link" {
  value = google_compute_network.main.self_link
}
output "subnetwork_link" {
  value = google_compute_subnetwork.public.self_link
}