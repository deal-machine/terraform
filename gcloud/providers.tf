terraform {
  required_version = ">= 0.13"
  required_providers {
    google = ">= 5.17.0"
    local  = ">= 2.4.1"
  }
  backend "gcs" { # cloud storage
    bucket = "deal-bucket-tf"
    prefix = "tf/state"
  }
}
provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("./credentials.json")
  zone        = var.zone
}
provider "kubernetes" {
  host                   = module.gke.cluster_endpoint
  token                  = module.gke.cluster_auth
  cluster_ca_certificate = base64decode(module.gke.certificate)
}
