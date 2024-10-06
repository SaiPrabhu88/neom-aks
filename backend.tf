terraform {
  backend "azurerm" {
    storage_account_name = "aks77"
    resource_group_name = "aksrg"
    container_name = "aks-container"
    key = "terraform.tfstate"
  }
}