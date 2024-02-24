resource "google_container_cluster" "cluster" {
  name                = "${var.prefix}-cluster"
  location            = var.region
  initial_node_count  = 1
  enable_autopilot    = true
  deletion_protection = false
  network             = var.network_id
  subnetwork          = var.subnet_id
  project             = var.project_id
  # monitoring_config {
  #   enable_components = ["SYSTEM_COMPONENTS", "APISERVER", "SCHEDULER", "CONTROLLER_MANAGER", "STORAGE", "HPA", "POD", "DAEMONSET", "DEPLOYMENT", "STATEFULSET"]
  #   # Habilita o Metrics Server
  # }
  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = true
    }
    # network_policy_config {
    #   disabled = false
    # }
  }
  # monitoring_config {
  #   enable_components = ["HPA", "DEPLOYMENT", "POD", "STORAGE"]
  # }
}
data "google_client_config" "provider" {}

