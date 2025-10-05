output "gateway_nsg_id" {
  value = azurerm_network_security_group.gateway.id
}

output "webapp_nsg_id" {
  value = azurerm_network_security_group.webapp.id
}

output "database_nsg_id" {
  value = azurerm_network_security_group.database.id
}