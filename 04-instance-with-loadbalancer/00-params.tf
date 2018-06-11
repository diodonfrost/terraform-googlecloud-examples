# params file for google cloud plateform

#### REGIONS / ZONES

# Define region to deploy
variable "gcp_region" {
  default = "europe-west2"
}

#### IMAGES

# Set google cloud image
variable "image" {
  default = "ubuntu-1604-xenial-v20180522"
}

#### NETWORK PARAMS
variable "params_http" {
  default = {
    template_name    = "template-http"
    net_name         = "network-http"
    desired_capacity = "2"
  }
}
