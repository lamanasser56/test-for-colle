
# Gateway Subnet
resource "azurerm_subnet" "gateway" {
  name                 = var.subnets["gateway"].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnets["gateway"].address_prefixes
}

# Web App Subnet (بدون delegation حالياً)
resource "azurerm_subnet" "webapp" {
  name                 = var.subnets["webapp"].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnets["webapp"].address_prefixes
}

# Database Subnet
resource "azurerm_subnet" "database" {
  name                 = var.subnets["database"].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.subnets["database"].address_prefixes
  
  private_endpoint_network_policies_enabled = false
}
