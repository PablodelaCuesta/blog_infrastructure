
# Defined virtual networks (VPC)

# Variables
variable "region" {
  default = "ams3"
  type    = string
}

variable "ip_range" {
  default = "10.2.1.0/16"
  type    = string
}

resource "digitalocean_vpc" "vpc_blog" {
  name     = "blog-network"
  region   = var.region
  ip_range = var.ip_range
}


# Load balancer
resource "digitalocean_loadbalancer" "public-lb" {
  name     = "loadbalancer"
  region   = var.region
  vpc_uuid = digitalocean_vpc.vpc_blog.id

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = [
    digitalocean_droplet.blog-public.id
  ]
}

# Firewall

resource "digitalocean_firewall" "ssh-icmp-and-outbound" {
  name = "allow-ssh-and-icmp"

  droplet_ids = [
    digitalocean_droplet.blog-public.id,
    digitalocean_droplet.blog-private.id,
    digitalocean_droplet.blog-database.id,
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


resource "digitalocean_firewall" "fw-public" {
  name = "allow-http-https-public"

  droplet_ids = [
    digitalocean_droplet.blog-public.id
  ]

  inbound_rule {
    protocol                  = "tcp"
    port_range                = "80"
    source_load_balancer_uids = [digitalocean_loadbalancer.public-lb.id]
  }

  inbound_rule {
    protocol                  = "tcp"
    port_range                = "443"
    source_load_balancer_uids = [digitalocean_loadbalancer.public-lb.id]
  }
}

resource "digitalocean_firewall" "fw-private" {
  name = "allow-http-https-private"

  droplet_ids = [
    digitalocean_droplet.blog-private.id
  ]

  inbound_rule {
    protocol           = "tcp"
    port_range         = "80"
    source_droplet_ids = [digitalocean_droplet.blog-public.id]
  }

  inbound_rule {
    protocol           = "tcp"
    port_range         = "443"
    source_droplet_ids = [digitalocean_droplet.blog-public.id]
  }
}

resource "digitalocean_firewall" "fw-database" {
  name = "allow-mysql-traffic-form-backend"

  droplet_ids = [digitalocean_droplet.blog-database.id]

  inbound_rule {
    protocol   = "tcp"
    port_range = "3306"
    source_droplet_ids = [
      digitalocean_droplet.blog-private.id
    ]
  }
}