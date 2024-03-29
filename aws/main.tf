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
  cluster_name   = var.cluster_name
}
module "rds" {
  source      = "./modules/rds"
  prefix      = var.prefix
  subnet_ids  = module.vpc.subnet_ids
  vpc_id      = module.vpc.vpc_id
  database_id = var.database_id
}
module "api-gateway" {
  source     = "./modules/api-gateway"
  prefix     = var.prefix
  invoke_arn = module.lambda.invoke_arn
}
module "lambda" {
  source        = "./modules/lambda"
  role_arn      = var.role_arn
  prefix        = var.prefix
  execution_arn = module.api-gateway.execution_arn
  region        = var.region
  user_arn      = var.user_arn
}
module "k8s" {
  source            = "./modules/k8s"
  database_id       = var.database_id
  database_endpoint = module.rds.database_endpoint
  database_username = module.rds.database_username
  database_port     = module.rds.database_port
  database_password = module.rds.database_password
  database_db_name  = module.rds.database_db_name
  database_hostname = module.rds.rds_hostname
}

/*
  adicionar imagem no ecr
  estudar ci/ci com terraform
    - git hub actions
    - merge protegido
  integrar com servico de autenticação + verificar regras de autenticação

  1 repo api-gateway + lambda (autenticação)
  1 repo cluster (vpc, eks, k8s)
  1 repo banco de dados (rds)
  1 repo app (orderly)

  documentar e detalhar banco de dados
    - rds (postgres)
    - redis

  investigar viabilidade de migrar para gcloud

  ssm
  dns (gratuito)
  senhas seguras (cofre de senhas)
  segurança e redes privadas

  agw -> cognito
  agw -> lambda
  agw -> rds
*/