resource "azurerm_resource_group" "aksrg" {
  name     = "raks"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "akscls" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.aksrg.location
  resource_group_name = azurerm_resource_group.aksrg.name
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
  value     = azurerm_kubernetes_cluster.akscls.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.akscls.kube_config_raw

  sensitive = true
}