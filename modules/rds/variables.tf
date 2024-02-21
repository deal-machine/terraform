variable "subnet_ids" {
  type = list(string)
  description = "Subnets IDS"
}
variable prefix {
    type = string
    description = "prefix name"
}
variable "vpc_id" {
  type = string
  description = "VPC identification"
}