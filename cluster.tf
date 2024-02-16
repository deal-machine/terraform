resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.vpc.id
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }
    tags = {
      Name = "${var.prefix}-sg"
    }
}

resource "aws_cloudwatch_log_group" "log" {
    name = "${var.prefix}/eks/cluster"
    retention_in_days = var.retention_days
}

resource "aws_eks_cluster" "cluster" {
    name = "${var.prefix}-cluster"
    role_arn = "arn:aws:iam::992382828900:role/LabRole"
    enabled_cluster_log_types = ["api", "audit"]
    vpc_config {
      subnet_ids = aws_subnet.subnets[*].id
      security_group_ids = [aws_security_group.sg.id]
    }
    depends_on = [ aws_cloudwatch_log_group.log
     # policies
    
     ]
}

# resource "aws_iam_role" "cluster" {
#   name = "${var.prefix}-cluster-role"
#   assume_role_policy = jsonencode({
#         "Version": "2012-10-17",
#         "Statement": [
#             {
#                 "Effect": "Allow",
#                 "Principal": {
#                     "Service": "eks.amazonaws.com",
#                     "AWS": "arn:aws:iam::992382828900:role/LabRole"
#                 },
#                 "Action": "sts:AssumeRole"
#             }
#         ]
#     })

#   tags = {
#     Name = "${var.prefix}-cluster-role"
#   }
  
# }

# resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
#     role = var.role_name
#     policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
# }
# resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSVPCResourceController" {
#     role = var.role_name
#     policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
# }

# resource "aws_iam_role_policy_attachment" "cluster-AmazonEC2ContainerRegistryReadOnly" {
#     role = "LabRole"
#     policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }

# resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSWorkerNodePolicy" {
#     role = "LabRole"
#     policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
# }

