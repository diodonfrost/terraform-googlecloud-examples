# params file for google cloud plateform

#### IMAGES

# Set google cloud image
variable "image" {
  default = "ubuntu-1604-xenial-v20180522"
}

#### NETWORK PARAMS
variable "network_http" {
  default = {
    subnet_name = "subnet-http"
    cidr        = "192.168.1.0/24"
  }
}

# Set number of http instances
variable "desired_capacity_http" {
  default = 2
}

variable "network_db" {
  default = {
    subnet_name = "subnet-db"
    cidr        = "192.168.2.0/24"
  }
}

# Set number of db instances
variable "desired_capacity_db" {
  default = 3
}
