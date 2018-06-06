# Network configuration

# VPC creation
resource "google_compute_network" "terraform" {
  name = "vpc-terraform"
}

# http subnet configuration
resource "google_compute_subnetwork" "http" {
  name          = "${var.network_http["subnet_name"]}"
  ip_cidr_range = "${var.network_http["cidr"]}"
  network       = "${google_compute_network.terraform.self_link}"
}

# db subnet configuration
resource "google_compute_subnetwork" "db" {
  name          = "${var.network_db["subnet_name"]}"
  ip_cidr_range = "${var.network_db["cidr"]}"
  network       = "${google_compute_network.terraform.self_link}"
}
