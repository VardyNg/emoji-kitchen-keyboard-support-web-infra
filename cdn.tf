resource "azurerm_cdn_profile" "default" {
  name                = "${var.app_name}-cdn"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = "Standard_Verizon"
}

resource "azurerm_cdn_endpoint" "default" {
  name                = "${var.app_name}-endpoint"
  profile_name        = azurerm_cdn_profile.default.name
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  origin {
    name      = var.app_name
    host_name = azurerm_storage_account.web-storage-account.primary_web_host
  }
}
resource "azurerm_cdn_endpoint_custom_domain" "default" {
  name            = "${var.app_name}-cdn-custom-domain"
  cdn_endpoint_id = azurerm_cdn_endpoint.default.id
  host_name       = local.fqdn
}