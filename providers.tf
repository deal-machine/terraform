terraform {
    required_version = ">= 0.13"
    required_providers {
        aws = ">= 5.37.0"
        local = ">= 2.4.1"
    }
}

provider "aws" {
  region = "us-east-1"
}