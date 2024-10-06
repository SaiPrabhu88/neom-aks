resource "azurerm_resource_group" "aks_rg" {
  name     = "aksResourceGrouprg"
  location = "centralindia"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "myAKSClusteraks"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "myaksdnnss"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
  kubernetes_version = "1.30.2"

  tags = {
    environment = "development"
  }
}
output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}