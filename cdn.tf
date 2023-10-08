resource "azurerm_cdn_profile" "default" {
  name                = "${var.app-name}-cdn"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = "Standard_Verizon"
}

resource "azurerm_cdn_endpoint" "default" {
  name                = "${var.app-name}-endpoint"
  profile_name        = azurerm_cdn_profile.default.name
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  origin {
    name      = var.app-name
    host_name = azurerm_storage_account.web-storage-account.primary_web_host
  }
}