#### INSTANCE GROUP HTTP ####

# Configure http selfhealing
resource "google_compute_health_check" "http" {
  name                = "health-check-http"
  check_interval_sec  = 10
  timeout_sec         = 10
  healthy_threshold   = 3
  unhealthy_threshold = 3

  http_health_check {
    request_path = "/"
    port         = "80"
  }
}

# http instance group
resource "google_compute_region_instance_group_manager" "http" {
  name               = "group-manager-http"
  base_instance_name = "${var.params_http["template_name"]}"
  instance_template  = "${google_compute_instance_template.http.self_link}"
  region             = "${var.gcp_region}"
  target_size        = "${var.params_http["desired_capacity"]}"

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = "${google_compute_health_check.http.self_link}"
    initial_delay_sec = 300
  }
}
