#### INSTANCE GROUP DB ####

# Configure db selfhealing
resource "google_compute_health_check" "db" {
  name                = "health-check-db"
  check_interval_sec  = 20
  timeout_sec         = 20
  healthy_threshold   = 3
  unhealthy_threshold = 3

  tcp_health_check {
    port         = "3306"
  }
}

# db instance group
resource "google_compute_region_instance_group_manager" "db" {
  count              = "${length(var.gcp_region)}"
  name               = "group-manager-db"
  base_instance_name = "${var.params_db["template_name"]}"
  instance_template  = "${google_compute_instance_template.db.self_link}"
  region             = "${element(var.gcp_region, count.index)}"

  named_port {
    name = "db"
    port = 5222
  }

  auto_healing_policies {
    health_check      = "${google_compute_health_check.db.self_link}"
    initial_delay_sec = 300
  }
}

# Set autoscaling db
resource "google_compute_region_autoscaler" "db" {
  count  = "${length(var.gcp_region)}"
  name   = "autoscaler-db"
  region = "${element(var.gcp_region, count.index)}"
  target = "${element(google_compute_region_instance_group_manager.db.*.self_link, count.index)}"

  autoscaling_policy = {
    max_replicas    = 6
    min_replicas    = 1
    cooldown_period = 60

    load_balancing_utilization {
      target = 0.8
    }
  }
}
