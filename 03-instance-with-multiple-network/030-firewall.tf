# Firewallconfiguration

# Default administration port
resource "google_compute_firewall" "administration" {
  name    = "administration"
  network = "${google_compute_network.terraform.name}"

  # Open ssh port
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Allow icmp
  allow {
    protocol = "icmp"
  }

  # tags used by our http instance
  target_tags = ["http"]
  source_ranges = ["0.0.0.0/0"]
}

# Open web port
resource "google_compute_firewall" "web" {
  name    = "web"
  network = "${google_compute_network.terraform.name}"

  # Open http and https
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  # tags used by our http instance
  target_tags = ["http"]
  source_ranges = ["0.0.0.0/0"]
}

# Open database port
resource "google_compute_firewall" "db" {
  name    = "db"
  network = "${google_compute_network.terraform.name}"

  # Open database port
  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }

  # tags used by our db instance
  target_tags = ["db"]
  source_ranges = ["0.0.0.0/0"]
}
