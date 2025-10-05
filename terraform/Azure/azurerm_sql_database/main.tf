# ============ Variables ============
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }
variable "subnet_id" { type = string }

variable "sql_server_name" {
  type    = string
  default = "sqlserver-burgerbuilder"
}

variable "sql_admin_login" {
  type    = string
  default = "lamaadmin"
}

variable "sql_admin_password" {
  type        = string
  description = "Admin password for SQL Server"
}

variable "database_name" {
  type    = string
  default = "burgerbuilderdb"
}

# ============ SQL Server ============
resource "azurerm_mssql_server" "this" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password

  public_network_access_enabled = false # 🔒 مهم للأمان

  tags = var.tags
}

# ============ SQL Database ============
resource "azurerm_mssql_database" "this" {
  name           = var.database_name
  server_id      = azurerm_mssql_server.this.id
  sku_name       = "S0"
  max_size_gb    = 5
  zone_redundant = false
  tags           = var.tags
}

# ============ Private Endpoint ============
resource "azurerm_private_endpoint" "sql_pe" {
  name                = "pe-sql-burgerbuilder"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "psc-sql"
    private_connection_resource_id = azurerm_mssql_server.this.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }

  tags = var.tags
}

# ============ Private DNS Zone ============
resource "azurerm_private_dns_zone" "sql_dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_group" "sql_dns_group" {
  name                = "sql-dns-group"
  private_endpoint_id = azurerm_private_endpoint.sql_pe.id

  private_dns_zone_configs {
    name                = azurerm_private_dns_zone.sql_dns.name
    private_dns_zone_id = azurerm_private_dns_zone.sql_dns.id
  }
}

# ============ Outputs ============
output "sql_server_name" {
  value = azurerm_mssql_server.this.name
}

output "sql_database_name" {
  value = azurerm_mssql_database.this.name
}

output "private_endpoint_id" {
  value = azurerm_private_endpoint.sql_pe.id
}
