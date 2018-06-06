#### INSTANCE DB ####

# Create instance
resource "google_compute_instance" "db" {
  name         = "db-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  tags = ["db"]

  boot_disk {
    source = "${google_compute_disk.db.name}"
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.http.self_link}"
    access_config {
      nat_ip = "${google_compute_address.db.address}"
    }
  }

  # add ssh key to instance
  metadata {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }

  metadata_startup_script = "${file("scripts/first-boot.sh")}"
}

 Creates a static IP address resource for db instance
resource "google_compute_address" "db" {
  name = "public-db"
}

# Create additionnal volume
resource "google_compute_disk" "db" {
  name  = "db-volume"
  type  = "pd-ssd"
  zone  = "us-central1-a"
  image = "${var.image}"
  size  = 15
}
