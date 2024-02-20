resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block # "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "${var.prefix}-vpc"
    }
}

data "aws_availability_zones" "available" {}
output "availability_zones" {
  value = data.aws_availability_zones.available.names
}

resource "aws_subnet" "subnets" {
    # gera um tipo de loop com quantidade de laços = 3
    count = 3
    vpc_id = aws_vpc.vpc.id
    map_public_ip_on_launch = true
    cidr_block = "10.0.${count.index}.0/24"
    availability_zone = data.aws_availability_zones.available.names[count.index]
    tags = {
      Name = "${var.prefix}-subnet-${count.index}"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
  tags = {
      Name = "${var.prefix}-igw"
    }
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
      Name = "${var.prefix}-rtb"
    }
}

resource "aws_route_table_association" "rtb-association" {
  route_table_id = aws_route_table.rtb.id
  count = 3
  subnet_id = aws_subnet.subnets.*.id[count.index]
}