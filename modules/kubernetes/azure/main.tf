resource "azurerm_resource_group" "rg" {
  name     = "${var.cluster_name}-rg"
  location = var.region
}

resource "azurerm_kubernetes_cluster" "primary" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_type
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Outputs
output "cluster_endpoint" {
  value     = azurerm_kubernetes_cluster.primary.kube_config.0.host
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = base64decode(azurerm_kubernetes_cluster.primary.kube_config.0.cluster_ca_certificate)
  sensitive = true
}
