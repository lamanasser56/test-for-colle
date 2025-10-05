
# Resource Group
module "resource_group" {
  source = "./Azure/azurerm_resource_group"

  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.common_tags
}

# Virtual Network
module "virtual_network" {
  source = "./Azure/azurerm_virtual_network"

  project_name        = local.project_name
  environment         = local.environment
  location            = local.location
  resource_group_name = module.resource_group.resource_group_name
  vnet_address_space  = local.vnet_address_space
  tags                = local.common_tags

  depends_on = [module.resource_group]
}

# Subnets
module "subnets" {
  source = "./Azure/azurerm_subnet"

  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.virtual_network.vnet_name
  subnets              = local.subnets

  depends_on = [module.virtual_network]
}
module "nsg" {
  source = "./Azure/azurerm_nsg"

  environment         = local.environment
  location            = local.location
  resource_group_name = module.resource_group.resource_group_name
  gateway_subnet_id   = module.subnets.gateway_subnet_id
  webapp_subnet_id    = module.subnets.webapp_subnet_id
  database_subnet_id  = module.subnets.database_subnet_id
  tags                = local.common_tags

  depends_on = [module.subnets]
}
module "private_dns_zone" {
  source = "./Azure/azurerm_private_dns_zone"

  resource_group_name = module.resource_group.resource_group_name
  vnet_id             = module.virtual_network.vnet_id
  tags                = local.common_tags

  depends_on = [module.virtual_network]
}
module "sql_server" {
  source = "./Azure/azurerm_mssql_server"

  project_name        = local.project_name
  environment         = local.environment
  resource_group_name = module.resource_group.resource_group_name
  location            = local.sql_location
  admin_username      = local.db_admin_username
  admin_password      = var.db_admin_password
  tags                = local.common_tags

  depends_on = [module.resource_group]
}
module "sql_database" {
  source = "./Azure/azurerm_mssql_database"

  sql_server_id = module.sql_server.sql_server_id
  database_sku  = local.sql_sku
  tags          = local.common_tags

  depends_on = [module.sql_server]
}
module "private_endpoint" {
  source = "./Azure/azurerm_private_endpoint"

  environment         = local.environment
  location            = local.location
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.subnets.database_subnet_id
  sql_server_id       = module.sql_server.sql_server_id
  private_dns_zone_id = module.private_dns_zone.sql_private_dns_zone_id
  tags                = local.common_tags

  depends_on = [module.sql_server, module.private_dns_zone]
}