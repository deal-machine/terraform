variable "access_key" {
  type        = string
  description = "aws_access_key_id"
}
variable "secret_key" {
  type        = string
  description = "aws_secret_access_key"
}
variable "token" {
  type        = string
  description = "aws_session_token"
}
variable "region" {
  type        = string
  description = "aws_region"
}

variable "prefix" {
  type        = string
  description = "prefix name"
}
variable "cluster_name" {
  type        = string
  description = "cluster name"
}

variable "role_name" {
  type        = string
  description = "role name"
}
variable "retention_days" {
  type        = number
  description = "log retention days"
}
variable "cidr_block" {
  type        = string
  description = "cidr block"
}
variable "role_arn" {
  type        = string
  description = "ARN data"
}
variable "user_arn" {
  type        = string
  description = "ARN user data"
}
variable "subnet_quantity" {
  type        = number
  description = "subnet quantities"
}

variable "database_id" {
  type        = string
  description = "database_id"
}