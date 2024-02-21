module "vpc" {
  source          = "./modules/vpc"
  prefix          = var.prefix
  cidr_block      = var.cidr_block
  subnet_quantity = var.subnet_quantity
}
module "eks" {
  source         = "./modules/eks"
  prefix         = var.prefix
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.subnet_ids
  retention_days = var.retention_days
  role_arn       = var.role_arn
}
module "rds" {
  source     = "./modules/rds"
  prefix     = var.prefix
  subnet_ids = module.vpc.subnet_ids
  vpc_id     = module.vpc.vpc_id
}
module "lambda" {
  source        = "./modules/lambda"
  role_arn      = var.role_arn
  prefix        = var.prefix
  execution_arn = module.api-gateway.execution_arn
  region        = var.region
  user_arn      = var.user_arn
}
module "api-gateway" {
  source     = "./modules/api-gateway"
  prefix     = var.prefix
  invoke_arn = module.lambda.invoke_arn
}