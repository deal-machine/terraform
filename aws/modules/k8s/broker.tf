resource "kubernetes_config_map" "broker_configmap" {
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

