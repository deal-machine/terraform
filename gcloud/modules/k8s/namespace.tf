resource "kubernetes_namespace" "ns" {
  metadata {
    name = "orderly"
  }
}