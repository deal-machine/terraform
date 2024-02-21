terraform {
  required_version = ">= 0.13"
  required_providers {
    aws   = ">= 5.37.0"
    local = ">= 2.4.1"
  }
  backend "s3" {
    bucket = "deal-terraform-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
}

# provider "kubernetes" {
#   config_path    = "${local_file.kubeconfig.filename}"
#   config_context = "${aws_eks_cluster.cluster.name}"
# }

# resource "kubernetes_namespace" "namespace" {
#   metadata {
#     name = "aws-namespace"
#   }
# }