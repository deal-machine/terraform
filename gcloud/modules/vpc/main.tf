resource "google_compute_network" "vpc" {
  name                    = "${var.prefix}-vpc"
  description             = "Compute Network by Terraform"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  project                 = var.project_id
}
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.prefix}-subnet"
  network       = google_compute_network.vpc.id
  region        = var.region
  ip_cidr_range = var.cidr
  description   = "Compute SubNetwork by Terraform"
  # private_ip_google_access = false
}
resource "google_compute_firewall" "allow_sql_external" {
  name    = "${var.prefix}-allow-sql-external"
  network = google_compute_network.vpc.self_link
  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = ["0.0.0.0/0"] # Permitir acesso de qualquer IP externo
}

# resource "google_compute_instance" "vm" {
#   name                      = "${var.prefix}-vm"
#   machine_type              = "f1-micro"
#   zone                      = var.zone
#   allow_stopping_for_update = false
#   description               = "Compute Instance by Terraform"
#   project                   = var.project_id

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#       labels = {
#         name = "${var.prefix}-vm"
#       }
#     }
#   }

#   network_interface {
#     network    = google_compute_network.vpc.self_link
#     subnetwork = google_compute_subnetwork.subnet.self_link
#     access_config {
#       // Ephemeral public IP
#     }
#   }
# }


# resource "google_compute_router" "router" {
#   name    = "${var.prefix}-router"
#   region  = var.region
#   network = google_compute_network.vpc.id
# }

# resource "google_compute_router_nat" "nat" {
#   name                               = "${var.prefix}-router-nat"
#   router                             = google_compute_router.router.name
#   region                             = var.region
#   source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
#   nat_ip_allocate_option             = "MANUAL_ONLY"
#   subnetwork {
#     name                    = google_compute_subnetwork.subnet.id
#     source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
#   }
# }

# resource "google_compute_address" "address" {
#   name         = "${var.prefix}-address"
#   region       = google_compute_subnetwork.subnet.region
#   address_type = "EXTERNAL"
#   depends_on   = [google_compute_instance.vm]
# }

# resource "google_compute_firewall" "allow_ssh" {
#   name    = "allow_ssh"
#   network = google_compute_network.vpc.name
#   allow {
#     protocol = "tcp"
#     ports    = ["80", "8080", "1000-4000", "22", "443", "5432"]
#   }
#   source_ranges = ["0.0.0.0/0", google_compute_subnetwork.subnet.ip_cidr_range]
# }