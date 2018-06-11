# params file for google cloud plateform

#### REGIONS / ZONES

# Define region to deploy
variable "gcp_region" {
  default = [
    "europe-west2",
    "us-west1",
    "asia-east1"
  ]
}

#### IMAGES

# Set google cloud image
variable "image" {
  default = "ubuntu-1604-xenial-v20180522"
}

#### NETWORK PARAMS
variable "params_http" {
  default = {
    template_name = "template-http"
    net_name      = "network-http"
  }
}

variable "params_db" {
  default = {
    template_name = "template-db"
    net_name      = "network-db"
  }
}
