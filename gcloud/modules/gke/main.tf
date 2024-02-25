resource "google_container_cluster" "cluster" {
  name                = "${var.prefix}-cluster"
  location            = var.region
  initial_node_count  = 1
  enable_autopilot    = true
  deletion_protection = false
  network             = var.network_self_link
  subnetwork          = var.subnetwork_self_link
  project             = var.project_id
  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
}

# # Permite tráfego de saída do GKE para o Cloud SQL
# resource "google_compute_firewall" "allow_sql" {
#   name    = "${var.prefix}-allow-sql"
#   network = var.network_self_link

#   allow {
#     protocol = "tcp"
#     ports    = ["5432"]
#   }

#   source_ranges = [google_compute_subnetwork.subnet.ip_cidr_range]
#   target_tags   = [google_container_cluster.cluster.] # google_container_cluster.my_cluster.node_pool_defaults[0].instance_group_urls[0]
# }


data "google_client_config" "provider" {}

