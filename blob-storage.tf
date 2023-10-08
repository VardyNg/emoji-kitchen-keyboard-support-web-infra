resource "azurerm_storage_account" "web-storage-account" {
  name                     = "${var.app-name}sa"
  resource_group_name      = azurerm_resource_group.default.name
  location                 = azurerm_resource_group.default.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "web-storage-container" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.web-storage-account.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "web-storage-blob" {
  name                   = "${var.app-name}sb"
  storage_account_name   = azurerm_storage_account.web-storage-account.name
  storage_container_name = azurerm_storage_container.web-storage-container.name
  type                   = "Block"
}