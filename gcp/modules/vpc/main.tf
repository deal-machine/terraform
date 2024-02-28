resource "google_compute_network" "main" {
  name                    = "main"
  project                 = var.project_id
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "public" {
  name          = "public"
  ip_cidr_range = "10.0.0.0/18"
  region        = "us-central1"
  network       = google_compute_network.main.id
  project       = var.project_id
}
resource "google_compute_router" "router" {
  name    = "router"
  project = var.project_id
  region  = "us-central1"
  network = google_compute_network.main.id
  bgp {
    asn = 64514
  }
}
resource "google_compute_router_nat" "nat" {
  name                               = "nat"
  router                             = google_compute_router.router.name
  region                             = "us-central1"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option             = "AUTO_ONLY"
  project                            = var.project_id
}
