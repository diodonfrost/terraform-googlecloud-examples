# params file for google cloud plateform

#### IMAGES

# Set google cloud image
variable "image" {
  default = "ubuntu-1604-xenial-v20180522"
}

#### NETWORK PARAMS
variable "network_http" {
  default = {
    subnet_name  = "subnet-http"
    cidr         = "192.168.1.0/24"
  }
}
