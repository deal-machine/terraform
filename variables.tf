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
variable "region" {
  type = string
  description = "aws_region"
}

variable prefix {
    type = string
    description = "prefix name"
} 
variable "role_name" {
  type = string
  description = "role name"
}
variable "retention_days" {
  type = number
  description = "log retention days"
}
variable cidr_block {
    type = string
    description = "cidr block"
}
variable "role_arn" {
    type = string
    description = "ARN data"
}