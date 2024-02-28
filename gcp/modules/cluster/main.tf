# CLUSTER
resource "google_container_cluster" "primary" {
  name                = "primary"
  location            = "us-central1"
  deletion_protection = false
  initial_node_count  = 1
  network             = var.network_link
  subnetwork          = var.subnetwork_link
  enable_autopilot    = true
  project             = var.project_id
}

data "google_client_config" "provider" {}
