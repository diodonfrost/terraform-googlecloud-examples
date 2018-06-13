#### INSTANCE DB ####

# Create instance
resource "google_compute_instance" "db" {
  name         = "db-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
  tags         = ["db"]

  # Set disk params
  boot_disk {
    source = "${google_compute_disk.db.name}"
  }

  # Set network params
  network_interface {
    subnetwork = "${google_compute_subnetwork.http.self_link}"
    access_config {}
  }

  # add ssh key to instance
  metadata {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }

  # Run this script at first boot
  metadata_startup_script = "${file("scripts/first-boot.sh")}"
}

# Create additionnal volume
resource "google_compute_disk" "db" {
  name  = "db-volume"
  type  = "pd-ssd"
  zone  = "us-central1-a"
  image = "${var.image}"
  size  = 15
}
