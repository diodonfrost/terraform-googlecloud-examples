#### LOADBALANCER ####

# Manages a global forwarding rule for http instance
resource "google_compute_global_forwarding_rule" "http" {
  name       = "forwarding-http"
  target     = "${google_compute_target_http_proxy.http.self_link}"
  port_range = "80-80"
}

# Define target url for http
resource "google_compute_target_http_proxy" "http" {
  name    = "target-http"
  url_map = "${google_compute_url_map.http.self_link}"
}

# Define http url
resource "google_compute_url_map" "http" {
  name            = "url-map-http"
  default_service = "${google_compute_backend_service.http.self_link}"
}

# Set member pool
resource "google_compute_backend_service" "http" {
  name          = "backend-http"
  port_name     = "http"
  protocol      = "HTTP"
  timeout_sec   = 30
  enable_cdn    = false
  health_checks = ["${google_compute_health_check.http.self_link}"]

  # Set backend for region 1
  backend {
    group = "${google_compute_region_instance_group_manager.http.instance_group}"
  }
}
