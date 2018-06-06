#### INSTANCE HTTP ####

# Create instance
resource "google_compute_instance" "http" {
  count        = "${var.desired_capacity_http}"
  name         = "http-instance${count.index}"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  tags = ["http"]

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.http.self_link}"
    access_config {
      nat_ip = "${element(google_compute_address.http.*.address, count.index)}"
    }
  }

  # add ssh key to instance
  metadata {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }

  metadata_startup_script = "${file("scripts/first-boot-http.sh")}"
}

# Creates a static IP address resource for http instance
resource "google_compute_address" "http" {
  count = "${var.desired_capacity_http}"
  name = "public-http${count.index}"
}
