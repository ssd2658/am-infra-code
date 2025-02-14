resource "azurerm_resource_group" "rg" {
  name     = "${var.database_name}-rg"
  location = var.region
}

resource "azurerm_postgresql_server" "postgres" {
  name                = var.database_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = var.instance_type

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  version                      = replace(var.database_version, "POSTGRES_", "")
  ssl_enforcement_enabled      = true

  tags = var.tags
}

resource "azurerm_postgresql_database" "database" {
  name                = var.database_name
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.postgres.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

# Outputs
output "database_endpoint" {
  value     = azurerm_postgresql_server.postgres.fqdn
  sensitive = true
}
