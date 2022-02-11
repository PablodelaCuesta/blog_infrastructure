
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.17.1"
    }
  }
}

variable "digital_ocean_token" {}

provider "digitalocean" {
  # Configuration options
  token = var.digital_ocean_token
}

