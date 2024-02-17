# provider "kubernetes" {
#   config_path    = "${local_file.kubeconfig.filename}"
#   config_context = "${aws_eks_cluster.cluster.name}"
# }

# resource "kubernetes_namespace" "namespace" {
#   metadata {
#     name = "aws-namespace"
#   }
# }