# Display IP information

# Internal address
output "http_external_address" {
  value = "${google_compute_address.http.address}"
}

output "db_external_address" {
  value = "${google_compute_address.db.address}"
}

# Internal address
output "http_internal_address" {
  value = "${google_compute_instance.http.network_interface.0.address}"
}

output "db_internal_address" {
  value = "${google_compute_instance.db.network_interface.0.address}"
}