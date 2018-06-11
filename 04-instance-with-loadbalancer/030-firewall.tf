# Firewall configuration

# Open web port
resource "google_compute_firewall" "web" {
  name    = "web"
  network = "${google_compute_network.http.name}"

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

  # tags used by our http instance
  target_tags = ["http"]
  source_ranges = ["0.0.0.0/0"]
}
