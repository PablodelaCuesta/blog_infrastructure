output "droplet-public-ip" {
  value = digitalocean_droplet.blog.ipv4_address
}
