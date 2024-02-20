module "vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
  cidr_block = var.cidr_block
}
module "eks" {
    source = "./modules/eks"
    prefix = var.prefix
    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.subnet_ids
    retention_days = var.retention_days
    role_arn = var.role_arn
}