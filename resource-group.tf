resource "azurerm_resource_group" "default" {
  name     = var.app_name
  location = var.rg_location
}