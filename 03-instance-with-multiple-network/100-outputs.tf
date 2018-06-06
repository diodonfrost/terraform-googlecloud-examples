# Display IP information

# Internal address
output "http_internal_address" {
  value = "${join(",",google_compute_instance.http.*.network_interface.0.address)}"
}

output "db_internal_address" {
  value = "${join(",",google_compute_instance.db.*.network_interface.0.address)}"
}

# External address
output "http_external_address" {
  value = "${join(",",google_compute_address.http.*.address)}"
}
