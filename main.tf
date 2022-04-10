
# Kubernetes definition
resource "digitalocean_kubernetes_cluster" "kubernetes_cluster" {
  name = "k8s-production"
  region = var.region
  version = "1.22.8-do-0"
  tags = [ "production" ]
  vpc_uuid = digitalocean_vpc.vpc_blog

  node_pool {
    name = "default-pool"
    size = "s-1vcpu-2gb"
    auto_scale = false
    node_count = 2
    tags = [ "node-pool" ]
  }
}

