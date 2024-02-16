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

variable prefix {
    type = string
    description = "prefix name"
} 
variable "role_name" {
  type = string
  description = "role name"
}