terraform {
  required_version = ">= 0.13"
  required_providers {
    google = ">= 5.17.0"
  }
}
provider "google" {
  project     = var.project_id
  region      = "us-central1"
  credentials = file("./credentials.json")
  zone        = "us-central1-c"
}
provider "kubernetes" {
  host                   = "https://${module.cluster.cluster_info.cluster_endpoint}"
  token                  = module.cluster.cluster_info.cluster_auth
  cluster_ca_certificate = base64decode(module.cluster.cluster_info.cluster_ca_certificate)
}