#### LOADBALANCER ####

# Manages a global forwarding rule for db instance
resource "google_compute_global_forwarding_rule" "db" {
  name       = "forwarding-db"
  target     = "${google_compute_target_tcp_proxy.db.self_link}"
  port_range = "5222"
}

# Define target db for http
resource "google_compute_target_tcp_proxy" "db" {
  name            = "target-db"
  backend_service = "${google_compute_backend_service.db.self_link}"
}

# Set backend params
resource "google_compute_backend_service" "db" {
  name        = "backend-db"
  port_name   = "db"
  protocol    = "TCP"
  timeout_sec = 30
  enable_cdn  = false

  # Set backend for region 1
  backend {
    group           = "${element(google_compute_region_instance_group_manager.db.*.instance_group, 0)}"
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
  }

  # Set backend for region 2
  backend {
    group           = "${element(google_compute_region_instance_group_manager.db.*.instance_group, 1)}"
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
  }

  # Set backend for region 3
  backend {
    group           = "${element(google_compute_region_instance_group_manager.db.*.instance_group, 2)}"
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8
  }

  health_checks = ["${google_compute_health_check.http.self_link}"]
}
