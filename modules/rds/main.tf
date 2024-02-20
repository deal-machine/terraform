resource "aws_db_subnet_group" "subnet" {
  name = "${var.prefix}-subnetgroup"
  subnet_ids = var.subnet_ids
  tags = {
      Name = "${var.prefix}-group"
    }
}
resource "aws_db_instance" "rds" {
  vpc_security_group_ids = var.sg_ids
  allocated_storage = 5
  max_allocated_storage = 10
  storage_type = "gp2"
  db_name = "postgres"
  publicly_accessible = true
  engine = "postgres"
  engine_version = "12"  
  instance_class = "db.t2.micro"
  username = "postgres"
  password = "postgres"
  db_subnet_group_name = aws_db_subnet_group.subnet.name
  tags = {
    Name = "${var.prefix}-rds"
  }  
}