resource "aws_vpc" "deal_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "${var.prefix}-vpc"
    }
}

data "aws_availability_zones" "available" {}
output "availability_zones" {
  value = data.aws_availability_zones.available.names
}

resource "aws_subnet" "subnets" {
    count = 3
    vpc_id = aws_vpc.deal_vpc.id
    map_public_ip_on_launch = true
    cidr_block = "10.0.${count.index}.0/24"
    availability_zone = data.aws_availability_zones.available.names[count.index]
    tags = {
      Name = "${var.prefix}-subnet-${count.index}"
    }
}