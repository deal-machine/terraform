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

provider "kubernetes" {
  host                   = module.eks.aws_eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.aws_eks_certificate)
  token                  = module.eks.aws_eks_cluster_auth
}
