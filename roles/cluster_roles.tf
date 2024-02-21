
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

