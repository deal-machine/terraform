# data "aws_eks_cluster_auth" "eks_cluster" {
#   name = aws_eks_cluster.cluster.name
# }
# resource "local_file" "kubeconfig" {
#   content  = data.aws_eks_cluster_auth.eks_cluster.name
#   filename = "kubeconfig"
# }

locals {
  kubeconfig = <<KUBECONFIG
    apiVersion: v1
    clusters:
    - cluster:
        server: ${aws_eks_cluster.cluster.endpoint}
        certificate-authority-data: ${aws_eks_cluster.cluster.certificate_authority[0].data}
    name: kubernetesku
    contexts:
    - context:
        cluster: kubernetes
        user: "${aws_eks_cluster.cluster.name}"
    name: "${aws_eks_cluster.cluster.name}"
    current-context: "${aws_eks_cluster.cluster.name}"
    kind: Config
    preferences: {}
    users:
    - name: "${aws_eks_cluster.cluster.name}"
    user:
        exec:
        apiVersion: client.authentication.k8s.io/v1alpha1
        command: aws-iam-authenticator
        args:
            - "token"
            - "-i"
            - "${aws_eks_cluster.cluster.name}"
KUBECONFIG
}
resource "local_file" "kubeconfig" {
  filename = "kubeconfig"
  content = local.kubeconfig
}

output "sg_ids" {
  value = aws_security_group.sg.id
}