resource "google_container_cluster" "cluster" {
  name                = "${var.prefix}-cluster"
  location            = var.region
  initial_node_count  = 1
  enable_autopilot    = true
  deletion_protection = false
  network             = var.network_self_link
  subnetwork          = var.subnetwork_self_link
  project             = var.project_id
}

data "google_client_config" "provider" {}

