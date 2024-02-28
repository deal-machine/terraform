resource "kubernetes_namespace" "ns" {
  metadata {
    name = "orderly"
  }
}
resource "kubernetes_config_map" "api_configmap" {
  metadata {
    name      = "api-configmap"
    namespace = "orderly"
  }
  depends_on = [kubernetes_namespace.ns]
  data = {
    PORT        = "3000"
    NODE_ENV    = "production"
    DB_HOST     = var.host
    DB_USERNAME = var.user
    DB_PORT     = var.port
    DB_PASSWORD = var.password
    DB_NAME     = var.database
    DB_DIALECT  = "postgres"
    # SOCKET_PATH      = "/cloudsql/${google_sql_database_instance.postgres.connection_name}"
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
  depends_on = [kubernetes_namespace.ns]
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
          image       = "dealmachine/orderly-api:8"
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
  depends_on = [kubernetes_namespace.ns]

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
resource "kubernetes_config_map" "broker_configmap" {
  depends_on = [kubernetes_namespace.ns]

  metadata {
    name      = "broker-configmap"
    namespace = "orderly"
  }

  data = {
    RABBITMQ_ERLANG_COOKIE = "DEALMACHINE"
    RABBITMQ_DEFAULT_USER  = "admin"
    RABBITMQ_DEFAULT_PASS  = "admin"
  }
}
resource "kubernetes_deployment" "broker_deployment" {
  depends_on = [kubernetes_namespace.ns]

  metadata {
    name      = "broker-deployment"
    namespace = "orderly"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "broker"
      }
    }

    template {
      metadata {
        labels = {
          app = "broker"
        }
      }

      spec {
        container {
          name  = "broker-container"
          image = "rabbitmq:3.12-management"

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

          env_from {
            config_map_ref {
              name = kubernetes_config_map.broker_configmap.metadata[0].name
            }
          }

          port {
            container_port = 5672
          }
          port {
            container_port = 15672
          }

          startup_probe {
            tcp_socket {
              port = 5672
            }
            period_seconds    = 5
            failure_threshold = 30
          }

          readiness_probe {
            tcp_socket {
              port = 5672
            }
            period_seconds    = 3
            failure_threshold = 3
          }

          liveness_probe {
            tcp_socket {
              port = 5672
            }
            period_seconds    = 1
            failure_threshold = 3
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "broker_service" {
  depends_on = [kubernetes_namespace.ns]

  metadata {
    name      = "broker-service"
    namespace = "orderly"
  }

  spec {
    type = "ClusterIP"

    selector = {
      app = "broker"
    }

    port {
      protocol    = "TCP"
      name        = "rabbitmq"
      port        = 5672
      target_port = 5672
    }
  }
}
resource "kubernetes_service" "broker_service_cp" {
  depends_on = [kubernetes_namespace.ns]

  metadata {
    name      = "broker-service-cp"
    namespace = "orderly"
  }

  spec {
    type = "LoadBalancer"

    selector = {
      app = "broker"
    }

    port {
      protocol    = "TCP"
      name        = "rabbitmq-controlpanel"
      port        = 15672
      target_port = 15672
      node_port   = 30672
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
#     max_replicas = 2

#     metric {
#       type = "Resource"

#       resource {
#         name = "cpu"
#         target {
#           type                = "Utilization"
#           average_utilization = 90
#         }
#       }
#     }
#   }
# }