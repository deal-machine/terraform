resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  name   = "${var.prefix}-rds-sg"
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
  tags = {
    Name = "${var.prefix}-sg"
  }
}
resource "aws_db_subnet_group" "subnet" {
  name = "${var.prefix}-subnetgroup"

  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.prefix}-group"
  }
}
resource "aws_db_parameter_group" "family" {
  name   = "${var.prefix}-family"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}
resource "aws_db_instance" "rds" {
  identifier = var.database_id

  instance_class        = "db.t3.micro"
  allocated_storage     = 5
  max_allocated_storage = 10
  storage_type          = "gp2"
  publicly_accessible   = true
  skip_final_snapshot   = true

  engine         = "postgres"
  engine_version = "14.6"
  db_name        = "orderly"
  username       = "postgres"
  password       = "postgres"
  port           = 5432

  db_subnet_group_name   = aws_db_subnet_group.subnet.name
  vpc_security_group_ids = [aws_security_group.sg.id]
  parameter_group_name   = aws_db_parameter_group.family.name

  tags = {
    Name = "${var.prefix}-rds"
  }
}