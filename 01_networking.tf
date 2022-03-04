
# Defined virtual networks (VPC)

# Variables
variable "region" {
  default = "ams3"
  type    = string
}

variable "ip_range" {
  default = "10.3.1.0/16"
  type    = string
}

resource "digitalocean_vpc" "vpc_blog" {
  name     = "blog-docker-network"
  region   = var.region
  ip_range = var.ip_range
}


# Firewall

resource "digitalocean_firewall" "ssh-icmp-and-outbound" {
  name = "allow-ssh-and-icmp"

  droplet_ids = [
    digitalocean_droplet.blog.id,
  ]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}


resource "digitalocean_firewall" "fw" {
  name = "allow-http-https-public"

  droplet_ids = [
    digitalocean_droplet.blog.id
  ]

  inbound_rule {
    protocol                  = "tcp"
    port_range                = "80"    
    source_addresses = [ "0.0.0.0/0", "::/0" ]
  }

  inbound_rule {
    protocol                  = "tcp"
    port_range                = "443"
    source_addresses = [ "0.0.0.0/0", "::/0" ]
  }
}