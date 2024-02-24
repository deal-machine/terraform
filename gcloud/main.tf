module "vpc" {
  source     = "./modules/vpc"
  prefix     = var.prefix
  region     = var.region
  project_id = var.project_id
}
module "sql" {
  source     = "./modules/sql"
  network_id = module.vpc.network_id
  prefix     = var.prefix
  region     = var.region
  project_id = var.project_id
}
# module "gke" {
#   source     = "./modules/gke"
#   network_id = module.vpc.network_id
#   subnet_id  = module.vpc.subnetwork_id
#   prefix     = var.prefix
#   region     = var.region
#   project_id = var.project_id
# }
# module "k8s" {
#   source            = "./modules/k8s"
#   database_id       = "orderly"
#   database_endpoint = module.sql.link
#   database_username = module.sql.username
#   database_port     = module.sql.port
#   database_password = module.sql.password
#   database_db_name  = module.sql.database
#   database_hostname = module.sql.link
# }