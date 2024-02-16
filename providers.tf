terraform {
    required_version = ">= 0.13"
    required_providers {
        aws = ">= 5.37.0"
        local = ">= 2.4.1"
    }
}

variable "access_key" {
  type = string
  description = "aws_access_key_id"
}
variable "secret_key" {
  type = string
  description = "aws_secret_access_key"
}
variable "token" {
  type = string
  description = "aws_session_token"
}

provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
  token = var.token
}