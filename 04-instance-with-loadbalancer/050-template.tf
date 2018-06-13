#### TEMPLATE HTTP ####

# Create http template
resource "google_compute_instance_template" "http" {
  name           = "${var.params_http["template_name"]}"
  machine_type   = "f1-micro"
  can_ip_forward = false
  tags           = ["http"]

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
