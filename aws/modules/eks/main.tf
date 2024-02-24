resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  name   = "${var.prefix}-eks-sg"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = [var.cidr_blocks]
    prefix_list_ids = []
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = [var.cidr_blocks]
    prefix_list_ids = []
  }
  tags = {
    Name = "${var.prefix}-sg"
  }
}
resource "aws_cloudwatch_log_group" "log" {
  name              = "${var.prefix}/eks/terraform/cluster"
  retention_in_days = var.retention_days
}
resource "aws_eks_cluster" "cluster" {
  name                      = var.cluster_name
  role_arn                  = var.role_arn
  enabled_cluster_log_types = ["api", "audit"]
  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = [aws_security_group.sg.id]
    endpoint_private_access = true
  }

  depends_on = [aws_cloudwatch_log_group.log]
  tags = {
    Name = var.cluster_name
  }
}
resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.prefix}-node"
  node_role_arn   = var.role_arn
  subnet_ids      = var.subnet_ids
  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }
  instance_types = ["t3.micro"]
}

data "aws_eks_cluster_auth" "auth" {
  name = aws_eks_cluster.cluster.name
}