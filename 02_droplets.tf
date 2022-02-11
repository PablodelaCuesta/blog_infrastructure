
## Droplets

resource "digitalocean_droplet" "blog-public" {
  name     = "blog"
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-20-04-x64"
  region   = var.region
  vpc_uuid = digitalocean_vpc.vpc_blog.id
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]

  backups    = true
  monitoring = true
}

resource "digitalocean_droplet" "blog-private" {
  name     = "blog-backend"
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-20-04-x64"
  region   = var.region
  vpc_uuid = digitalocean_vpc.vpc_blog.id
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]

  backups    = true
  monitoring = true
}

resource "digitalocean_droplet" "blog-database" {
  name     = "blog-database"
  size     = "s-1vcpu-1gb"
  image    = "ubuntu-20-04-x64"
  region   = var.region
  vpc_uuid = digitalocean_vpc.vpc_blog.id
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]

  backups    = true
  monitoring = true
}