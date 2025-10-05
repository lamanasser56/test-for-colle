resource "azurerm_mssql_database" "main" {
  name      = "db-burgerbuilder"
  server_id = var.sql_server_id
  sku_name  = var.database_sku
  tags      = var.tags
}