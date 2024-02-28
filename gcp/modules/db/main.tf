resource "google_sql_database_instance" "postgres" {
  name                = "postgresql-instance"
  region              = "us-central1"
  project             = var.project_id
  database_version    = "POSTGRES_14"
  deletion_protection = false
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "gke-cluster"
        value = var.cluster_endpoint
      }
      authorized_networks {
        name  = "allow-terraform"
        value = "0.0.0.0/0"
      }
    }
  }
}
resource "google_sql_database" "database" {
  project    = var.project_id
  name       = "orderly"
  charset    = "utf8"
  instance   = google_sql_database_instance.postgres.name
  depends_on = [google_sql_database_instance.postgres]
}
resource "google_sql_user" "user" {
  project    = var.project_id
  name       = "username"
  password   = "postgres"
  instance   = google_sql_database_instance.postgres.name
  depends_on = [google_sql_database_instance.postgres]
}