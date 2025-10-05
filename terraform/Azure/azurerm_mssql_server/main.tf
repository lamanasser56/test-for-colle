resource "azurerm_mssql_server" "main" {
  name                         = "sql-lama-${var.project_name}-${var.environment}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  public_network_access_enabled = false

  tags = var.tags
}