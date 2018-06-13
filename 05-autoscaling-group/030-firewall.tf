# Firewall configuration

# Open web port
resource "google_compute_firewall" "web" {
  name          = "web"
  network       = "${google_compute_network.http.name}"

  # tags used by our http instance
  target_tags   = ["http"]
  source_ranges = ["0.0.0.0/0"]

  # Open http and https
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

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

# Open database port
resource "google_compute_firewall" "db" {
  name          = "db"
  network       = "${google_compute_network.db.name}"

  # tags used by our db instance
  target_tags   = ["db"]
  source_ranges = ["0.0.0.0/0"]

  # Open database port
  allow {
    protocol = "tcp"
    ports    = ["3306", "5222"]
  }

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
