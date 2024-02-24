resource "google_sql_database_instance" "postgres" {
  name                = "${var.prefix}-postgres"
  database_version    = "POSTGRES_15"
  region              = var.region
  project             = var.project_id
  deletion_protection = false
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true # Ativado acesso público
      #   private_network = var.network_id
    }
  }
}
resource "google_sql_database" "database" {
  name     = "orderly"
  charset  = "utf8"
  instance = google_sql_database_instance.postgres.name
}
resource "google_sql_user" "user" {
  name     = var.prefix
  password = random_password.postgres_password.result
  instance = google_sql_database_instance.postgres.name
}

resource "random_password" "postgres_password" {
  length  = 16
  special = true
}
# api gatway
# resource "google_apigateway_api" "apigateway" {
#   display_name = "${var.prefix}-apigateway"
#   api_config {
#     # Configurações do API Gateway
#     backend {
#       rules {
#         selector = "your-backend-service"
#         address  = google_sql_database_instance.postgres.ip_address[0]
#       }
#     }
#   }
# }

# resource "google_compute_backend_service" "backend_service" {
#   name          = "${var.prefix}backend-service"
#   port_name     = "http"
#   protocol      = "HTTP"
#   timeout_sec   = 60
#   health_checks = [] # Você pode adicionar verificações de saúde, se necessário
#   enable_cdn    = false

#   backend {
#     group = google_sql_database_instance.postgres.name
#   }
# }

# resource "google_compute_firewall" "allow_api_gateway_traffic" {
#   name    = "${var.prefix}-allow-api-gateway-traffic"
#   network = var.network_name

#   allow {
#     protocol = "tcp"
#     ports    = ["5432"] # Porta do Postgres
#   }

#   source_ranges = [google_apigateway_api.apigateway.default_location_settings[0].address]
# }