variable "prefix" {
  type        = string
  description = "prefix name"
}
variable "retention_days" {
  type        = number
  description = "log retention days"
}
variable "vpc_id" {
  type        = string
  description = "VPC identification"
}
variable "subnet_ids" {
  type        = list(string)
  description = "Subnets IDS"
}
variable "role_arn" {
  type        = string
  description = "ARN data"
}
variable "cidr_blocks" {
  default = "0.0.0.0/0"
}
variable "cluster_name" {
  type        = string
  description = "cluster name"
}