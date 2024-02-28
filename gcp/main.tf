
module "network" {
  source = "./modules/vpc"
  depends_on = [
    google_project_service.cloudresourcemanager,
    google_project_service.compute,
    google_project_service.container,
    google_project_service.servicecontrol
  ]
  project_id = var.project_id
}
module "cluster" {
  source          = "./modules/cluster"
  depends_on      = [module.network]
  network_link    = module.network.network_link
  project_id      = var.project_id
  subnetwork_link = module.network.subnetwork_link
}
module "database" {
  source           = "./modules/db"
  depends_on       = [module.cluster, google_project_service.sqladmin]
  project_id       = var.project_id
  cluster_endpoint = module.cluster.cluster_info.cluster_endpoint
}
module "k8s" {
  source     = "./modules/k8s"
  depends_on = [module.cluster, module.database]
  host       = module.database.db_info.public_ip_address
  database   = module.database.db_info.database
  password   = module.database.db_info.password
  port       = 5432
  user       = module.database.db_info.user
}