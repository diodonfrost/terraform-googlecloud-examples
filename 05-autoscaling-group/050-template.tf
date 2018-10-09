#### TEMPLATE HTTP ####

# Create http template
resource "google_compute_instance_template" "http" {
  name           = "${var.params_http["template_name"]}"
  tags           = ["http"]
  machine_type   = "f1-micro"
  can_ip_forward = false

  # Define plannification strategy
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  # Create new disque
  disk {
    source_image = "${var.image}"
    auto_delete  = true
    boot         = true
  }

  # Set network params
  network_interface {
    network = "${google_compute_network.http.name}"
    access_config {}
  }

  # add ssh key to instance
  metadata {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }

  # Run this script at first boot
  metadata_startup_script = "${file("scripts/first-boot-http.sh")}"
}

#### TEMPLATE DB ####

# Create db template
resource "google_compute_instance_template" "db" {
  name           = "db-template"
  tags           = ["db"]
  machine_type   = "f1-micro"
  can_ip_forward = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  # Create new disque
  disk {
    source_image = "${var.image}"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "${google_compute_network.db.name}"
    access_config {}
  }

  # add ssh key to instance
  metadata {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }

  metadata_startup_script = "${file("scripts/first-boot-http.sh")}"

  lifecycle {
      ignore_changes = [
          "*"
      ]
  }
}
