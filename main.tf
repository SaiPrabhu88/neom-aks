resource "azurerm_resource_group" "aks-rg" {
  name     = "aks"
  location = "Central India"
}

resource "azurerm_kubernetes_cluster" "aks-cls" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.aks-rg.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = "akscluster1"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks-cls.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks-cls.kube_config_raw

  sensitive = true
}