# Display IP information

# Internal address
output "http_internal_address" {
  value = "${google_compute_address.http.address}"
}

# External address
output "http_external_address" {
  value = "${google_compute_instance.http.network_interface.0.address}"
}
