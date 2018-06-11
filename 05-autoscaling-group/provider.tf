# Configure the Google Cloud provider
provider "google" {
  credentials = "${file("gcp-terraform.json")}"
  project     = "gcp-terraform-206213"
  region      = "us-central1"
}
