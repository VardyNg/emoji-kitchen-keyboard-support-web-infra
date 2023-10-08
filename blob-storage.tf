resource "azurerm_storage_account" "web-storage-account" {
  name                     = "${var.app-name}sa"
  resource_group_name      = azurerm_resource_group.default.name
  location                 = azurerm_resource_group.default.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  static_website {
    index_document = "index.html"
    error_404_document = "index.html"
  }
}

resource "azurerm_storage_container" "web-storage-container" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.web-storage-account.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "web-storage-blob" {
  name                   = "${var.app-name}sb"
  storage_account_name   = azurerm_storage_account.web-storage-account.name
  storage_container_name = azurerm_storage_container.web-storage-container.name
  type                   = "Block"
}

resource "azurerm_storage_container" "tfstate-storage-container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.web-storage-account.name
  container_access_type = "blob"
}
resource "azurerm_storage_blob" "tfstate" {
  name                   = "${var.app-name}tfstate"
  storage_account_name   = azurerm_storage_account.web-storage-account.name
  storage_container_name = azurerm_storage_container.tfstate-storage-container.name
  type                   = "Block"
}