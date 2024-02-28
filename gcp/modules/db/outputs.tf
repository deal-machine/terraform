output "db_info" {
  value = {
    public_ip_address = google_sql_database_instance.postgres.public_ip_address
    connection_name   = google_sql_database_instance.postgres.connection_name
    user              = google_sql_user.user.name
    password          = google_sql_user.user.password
    host              = google_sql_user.user.host
    database          = google_sql_database.database.name
    sensitive         = true
  }
}