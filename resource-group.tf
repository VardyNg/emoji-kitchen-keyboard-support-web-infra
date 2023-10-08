resource "azurerm_resource_group" "default" {
  name     = var.app-name
  location = var.rg-location
}