# Display IP information

# External address
output "http_external_address" {
  value = "${google_compute_global_address.http.address}"
}
