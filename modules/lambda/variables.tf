variable "role_arn" {
  type        = string
  description = "ARN data"
}
variable "prefix" {
  type        = string
  description = "prefix name"
}

variable "execution_arn" {
  type        = string
  description = "aws_api_gateway_rest_api.ag.execution_arn"
}
variable "region" {
  type        = string
  description = "aws region"
}
variable "user_arn" {
  type        = string
  description = "ARN user data"
}