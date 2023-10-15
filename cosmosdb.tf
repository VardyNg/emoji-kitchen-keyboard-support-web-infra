resource "random_string" "db_account_name" {
  count = var.app_name == null ? 1 : 0

  length  = 20
  upper   = false
  special = false
  numeric = false
}

locals {
  cosmosdb_account_name = try(random_string.db_account_name[0].result, var.app_name)
}

resource "azurerm_cosmosdb_account" "form" {
  name                      = local.cosmosdb_account_name
  location                  = var.rg_location
  resource_group_name       = azurerm_resource_group.default.name
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  enable_automatic_failover = false
  geo_location {
    location          = var.rg_location
    failover_priority = 0
  }
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  capabilities {
    name = "EnableServerless"
  }

  depends_on = [
    azurerm_resource_group.default
  ]
}

resource "azurerm_cosmosdb_sql_database" "default" {
  name                = "${local.cosmosdb_account_name}-database"
  resource_group_name = azurerm_resource_group.default.name
  account_name        = azurerm_cosmosdb_account.form.name
}

resource "azurerm_cosmosdb_sql_container" "default" {
  name                  = "${local.cosmosdb_account_name}-container"
  resource_group_name   = azurerm_resource_group.default.name
  account_name          = azurerm_cosmosdb_account.form.name
  database_name         = azurerm_cosmosdb_sql_database.default.name
  partition_key_path    = "/definition/id"
  partition_key_version = 1

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }
}