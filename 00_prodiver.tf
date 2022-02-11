
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.17.1"
    }
  }
}

variable "digital_ocean_token" {}

provider "digitalocean" {
  # Configuration options
  token = var.digital_ocean_token
}


## SSH Connection to remote machines

resource "digitalocean_ssh_key" "default" {
  name       = "Key from terraform"
  public_key = file("~/.ssh/do/blog.pub")
}