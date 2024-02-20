resource "aws_db_subnet_group" "subnet" {
    name = "${var.prefix}-subnetgroup"
    subnet_ids = var.subnet_ids
    tags = {
        Name = "${var.prefix}-group"
    }
}
resource "aws_db_instance" "rds" {
    instance_class = "db.t3.micro"
    allocated_storage = 5
    max_allocated_storage = 10
    storage_type = "gp2"
    publicly_accessible = true

    engine = "postgres"
    engine_version= "14.1"
    db_name = "postgres"
    username = "postgres"
    password = "postgres"
    
    db_subnet_group_name = aws_db_subnet_group.subnet.name
    vpc_security_group_ids = var.sg_ids

    tags = {
        Name = "${var.prefix}-rds"
    }  
}