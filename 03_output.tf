output "droplet-public-ip" {
  value = digitalocean_droplet.blog-public
}

output "droplet-private-ip" {
  value = digitalocean_droplet.blog-private
}

