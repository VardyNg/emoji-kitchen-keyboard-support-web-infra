resource "azurerm_communication_service" "default" {
  name                = "${var.app_name}-communicationservice"
  resource_group_name = azurerm_resource_group.default.name
  data_location       = var.acs_data_location
}