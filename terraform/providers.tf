terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  backend "azurerm" {
    resource_group_name  = "lama-tfstate-rg"
    storage_account_name = "lamatfstate2025"
    container_name       = "tfstate"
    key                  = "burgerbuilder.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "80646857-9142-494b-90c5-32fea6acbc41"
}