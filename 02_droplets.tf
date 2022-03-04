
## Droplets

resource "digitalocean_droplet" "blog" {
  name     = "blog"
  size     = "s-2vcpu-2gb"
  image    = "ubuntu-20-04-x64"
  region   = var.region
  vpc_uuid = digitalocean_vpc.vpc_blog.id
  ssh_keys = [digitalocean_ssh_key.ssh.fingerprint]

  backups    = true
  monitoring = true

  provisioner "remote-exec" {
    inline = [
      "echo 'Connected to ${self.name}'"
    ]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
      agent = true
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.ipv4_address}' --private-key ${var.private_key_path} playbooks/client.yaml"
  }
}