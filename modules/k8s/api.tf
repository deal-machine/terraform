
resource "kubernetes_config_map" "api_configmap" {
  metadata {
    name      = "api-configmap"
    namespace = "orderly"
  }

  data = {
    PORT             = "3000"
    NODE_ENV         = "production"
    DB_HOST          = var.database_hostname
    DB_USERNAME      = var.database_username
    DB_PORT          = var.database_port
    DB_PASSWORD      = var.database_password
    DB_NAME          = var.database_db_name
    DB_DIALECT       = "postgres"
    AMQP_USERNAME    = "admin"
    AMQP_PASSWORD    = "admin"
    AMQP_COOKIE      = "DEALMACHINE"
    AMQP_PORT        = "5672"
    AMQP_HOST        = kubernetes_service.broker_service.metadata[0].name
    MP_URL           = "https://api.mercadopago.com"
    MP_CLIENT_SECRET = "TEST-5115720587610886-010418-c53a30aeee07e161df5918fcb5fb680c-152047844"
    MP_GRANT_TYPE    = "refresh_token"
    MP_REFRESH_TOKEN = "TG-659879899f59ca0001e6fe8b-152047844"
  }
}
resource "kubernetes_deployment" "api_deployment" {
  metadata {
    name      = "api-deployment"
    namespace = "orderly"
  }

  spec {
    replicas = 1

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
    selector {
      match_labels = {
        app = "api"
      }
    }

    template {

      metadata {
        labels = {
          app = "api"
        }
      }


      spec {
        container {
          name        = "api-container"
          image       = "dealmachine/orderly-api:7"
          working_dir = "/api"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          port {
            container_port = 3000
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.api_configmap.metadata[0].name
            }
          }

          startup_probe {
            http_get {
              path = "/orders"
              port = 3000
            }
            period_seconds    = 5
            failure_threshold = 30
          }

          readiness_probe {
            http_get {
              path = "/orders"
              port = 3000
            }
            period_seconds    = 3
            failure_threshold = 3
          }

          liveness_probe {
            http_get {
              path = "/orders"
              port = 3000
            }
            period_seconds    = 10
            timeout_seconds   = 3
            failure_threshold = 3
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "api_service" {
  metadata {
    name      = "api-service"
    namespace = "orderly"
  }

  spec {
    type = "LoadBalancer"

    selector = {
      app = "api"
    }

    port {
      protocol  = "TCP"
      port      = 3000
      node_port = 30000 # Only applicable if using "NodePort" type
    }
  }
}

# resource "kubernetes_horizontal_pod_autoscaler" "api_hpa" {
#   metadata {
#     name      = "api-hpa"
#     namespace = "orderly"
#   }

#   spec {
#     scale_target_ref {
#       api_version = "apps/v1"
#       kind        = "Deployment"
#       name        = kubernetes_deployment.api_deployment.metadata[0].name
#     }

#     min_replicas = 1
#     max_replicas = 10

#     metric {
#       type = "Resource"

#       resource {
#         name = "cpu"
#         target {
#           type                = "Utilization"
#           average_utilization = 70
#         }
#       }
#     }
#   }
# }
