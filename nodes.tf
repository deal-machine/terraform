resource "aws_eks_node_group" "node" {
    cluster_name = aws_eks_cluster.cluster.name
    node_group_name = "${var.prefix}-node"
    node_role_arn = "arn:aws:iam::992382828900:role/LabRole" 
    subnet_ids = aws_subnet.subnets[*].id
    scaling_config {
        desired_size = 2
        max_size = 4
        min_size = 2
    }
    depends_on = [ 
        # policies
    ]
    instance_types = ["t3.micro"]
}