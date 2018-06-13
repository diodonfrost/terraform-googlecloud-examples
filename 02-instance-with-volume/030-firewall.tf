# Firewallconfiguration

# Default administration port
resource "google_compute_firewall" "administration" {
  name          = "administration"
  network       = "${google_compute_network.terraform.name}"

  # tags used by our front instances
  target_tags   = ["http", "db"]
  source_ranges = ["0.0.0.0/0"]

  # Open ssh port
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Allow icmp
  allow {
    protocol = "icmp"
  }
}

# Open web port
resource "google_compute_firewall" "web" {
  name          = "web"
  network       = "${google_compute_network.terraform.name}"

  # tags used by our db instance
  target_tags   = ["http"]
  source_ranges = ["0.0.0.0/0"]

  # Open http and https
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}

# Open database port
resource "google_compute_firewall" "db" {
  name          = "db"
  network       = "${google_compute_network.terraform.name}"

  # tags used by our db instance
  target_tags   = ["db"]
  source_ranges = ["0.0.0.0/0"]
  # Open database port

  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }
}
