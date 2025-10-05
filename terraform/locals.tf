locals {
  project_name = "burgerbuilder"
  environment  = "dev"
  location     = "eastus"
  # tesstt SQL region different ----
  sql_location = "northeurope"

  resource_group_name = "rg-${local.project_name}-${local.environment}"

  vnet_address_space = ["10.0.0.0/16"]
  subnets = {
    gateway = {
      name             = "snet-gateway"
      address_prefixes = ["10.0.1.0/24"]
    }
    webapp = {
      name             = "snet-webapp"
      address_prefixes = ["10.0.2.0/23"]
    }
    database = {
      name             = "snet-database"
      address_prefixes = ["10.0.4.0/24"]
    }
  }

  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    ManagedBy   = "Terraform"
    Team        = "DevOps"
  }

  sql_sku = "Basic"

  db_admin_username = "sqladmin"

}