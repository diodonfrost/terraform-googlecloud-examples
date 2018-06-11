# Network configuration

# VPC creation
resource "google_compute_network" "http" {
  name                    = "${var.params_http["net_name"]}"
  auto_create_subnetworks = "true"
}

resource "google_compute_network" "db" {
  name                    = "${var.params_db["net_name"]}"
  auto_create_subnetworks = "true"
}
