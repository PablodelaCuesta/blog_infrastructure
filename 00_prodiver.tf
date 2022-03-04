
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.17.1"
    }
  }
}

variable "digital_ocean_token" {}
variable "private_key_path" {
  type        = string
  description = "Path to the private key used for this platform"
}
variable "public_key_path" {
  type        = string
  description = "Path to the public key used for this platform"
}

provider "digitalocean" {
  # Configuration options
  token = var.digital_ocean_token
}


## SSH Connection to remote machines

resource "digitalocean_ssh_key" "default" {
  name       = "Key from terraform"
  public_key = file(var.public_key_path)
}