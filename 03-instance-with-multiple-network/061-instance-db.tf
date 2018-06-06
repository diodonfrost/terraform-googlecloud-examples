#### INSTANCE DB ####

# Create instance
resource "google_compute_instance" "db" {
  count        = "${var.desired_capacity_db}"
  name         = "db-instance${count.index}"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  tags = ["db"]

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.db.self_link}"
    access_config {}
  }

  # add ssh key to instance
  metadata {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }

  metadata_startup_script = "${file("scripts/first-boot-db.sh")}"
}
