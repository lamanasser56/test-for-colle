output "gateway_subnet_id" {
  value = azurerm_subnet.gateway.id
}

output "webapp_subnet_id" {
  value = azurerm_subnet.webapp.id
}

output "database_subnet_id" {
  value = azurerm_subnet.database.id
}