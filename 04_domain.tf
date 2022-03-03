resource "digitalocean_domain" "blog_domain" {
  name = "pablodelacuesta.es"
  ip_address = digitalocean_droplet.blog-public.ipv4_address
}