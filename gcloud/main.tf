module "vpc" {
  source     = "./modules/vpc"
  prefix     = var.prefix
  region     = var.region
  project_id = var.project_id
  cidr = var.cidr
}
module "sql" {
  source     = "./modules/sql"
  network_id = module.vpc.network_id
  prefix     = var.prefix
  region     = var.region
  project_id = var.project_id
  cidr = var.cidr
}
module "gke" {
  source               = "./modules/gke"
  network_id           = module.vpc.network_id
  subnet_id            = module.vpc.subnetwork_id
  prefix               = var.prefix
  region               = var.region
  project_id           = var.project_id
  network_self_link    = module.vpc.network_self_link
  subnetwork_self_link = module.vpc.subnetwork_self_link
}
module "k8s" {
  source      = "./modules/k8s"
  db_host     = module.sql.host
  db_username = module.sql.username
  db_port     = module.sql.port
  db_password = module.sql.password
  db_name     = module.sql.database
}