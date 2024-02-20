variable "subnet_ids" {
  type = list(string)
  description = "Subnets IDS"
}
variable prefix {
    type = string
    description = "prefix name"
}
variable "sg_ids" {
  type = list(string)
  description = "Security Group IDS"
}