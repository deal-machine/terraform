output "host" {
  value = google_sql_database_instance.postgres.connection_name
}
output "database" {
  value = google_sql_database.database.name
}
output "username" {
  value = google_sql_user.user.name
}
output "port" {
  value = 5432
}
output "password" {
  value = google_sql_user.user.password
}
# Output para obter os valores de conexão
output "database_connection_info" {
  value = {
    host     = google_sql_database_instance.postgres.connection_name
    database = google_sql_database.database.name
    username = google_sql_user.user.name
    password = google_sql_user.user.password
  }
}