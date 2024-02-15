resource "aws_vpc" "deal_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "deal_vpc"
    }
}