output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.rds.address
  sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.rds.port
  sensitive   = true
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.rds.username
  sensitive   = true
}

output "database_endpoint" {
  description = "RDS instance root endpoint"
  value       = aws_db_instance.rds.endpoint
}
output "database_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.rds.username
}
output "database_port" {
  description = "RDS instance root port"
  value       = aws_db_instance.rds.port
}
output "database_password" {
  description = "RDS instance root password"
  value       = aws_db_instance.rds.password
}
output "database_db_name" {
  description = "RDS instance root db_name"
  value       = aws_db_instance.rds.db_name
}