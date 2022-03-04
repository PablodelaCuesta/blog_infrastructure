resource "digitalocean_domain" "blog_domain" {
  name       = "pablodelacuesta.es"
  ip_address = digitalocean_droplet.blog.ipv4_address
}

resource "digitalocean_record" "CNAME-www" {
  domain = digitalocean_domain.blog_domain.name
  type   = "CNAME"
  name   = "www"
  value  = "@"
}