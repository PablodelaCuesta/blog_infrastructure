
# Defined virtual networks (VPC)

# Variables
variable "region" {
  default = "ams3"
  type    = string
}

variable "ip_range" {
  default = "10.4.1.0/16"
  type    = string
}

resource "digitalocean_vpc" "vpc_blog" {
  name     = "blog-k8s-network"
  region   = var.region
  ip_range = var.ip_range
}

