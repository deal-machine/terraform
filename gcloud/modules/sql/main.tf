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
      
      authorized_networks {
        name = "my-local-ip"
        value = "187.23.249.217"
      }
      # authorized_networks {
      #   name = "open-house"
      #   value = "0.0.0.0/0"
      # }
      # authorized_networks {
      #   name = "gke-network"
      #   value = var.cidr
      # }
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
  password = "password"
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