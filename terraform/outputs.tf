output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "vnet_name" {
  value = module.virtual_network.vnet_name
}

output "subnet_ids" {
  value = {
    gateway  = module.subnets.gateway_subnet_id
    webapp   = module.subnets.webapp_subnet_id
    database = module.subnets.database_subnet_id
  }
}

output "sql_server_fqdn" {
  value     = module.sql_server.sql_server_fqdn
  sensitive = true
}