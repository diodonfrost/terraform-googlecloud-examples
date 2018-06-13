#### INSTANCE HTTP ####

# Create instance
resource "google_compute_instance" "http" {
  name         = "http-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  tags         = ["http"]

  # Set disk params
  boot_disk {
    initialize_params {
      image = "${var.image}"
      # set 10g for disk size
      size = "10"
    }
  }

  # Set network params
  network_interface {
    subnetwork = "${google_compute_subnetwork.http.self_link}"
    access_config {
      nat_ip = "${google_compute_address.http.address}"
    }
  }

  # add ssh key to instance
  metadata {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }

  # Run this script at first boot
  metadata_startup_script = "${file("scripts/first-boot.sh")}"
}

# Creates a static IP address resource for http instance
resource "google_compute_address" "http" {
  name = "public-http"
}
