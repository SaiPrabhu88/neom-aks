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
    node_count = 1 
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
  kubernetes_version = "1.27.7"

  tags = {
    environment = "development"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "additional_nodes" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = "additional"
  node_count            = 1 
  vm_size               = "Standard_B2s"
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}