# Configure Terraform to set the required AzureRM provider
# version and features{} block.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.107.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}
provider "azurerm" {
  features {}
}
provider "azurerm" {
  alias = "provider_sub_management"
  subscription_id = azurerm_subscription.sub_management.id
  features {}
}
provider "azurerm" {
  alias = "provider_sub_application"
  subscription_id = azurerm_subscription.sub_application.id
  features {}
}
provider "azurerm" {
  alias = "provider_sub_connectivity"
  subscription_id = azurerm_subscription.sub_connectivity.id
  features {}
}
provider "azurerm" {
  alias = "provider_sub_identity"
  subscription_id = azurerm_subscription.sub_identity.id
  features {}
}
provider "azurerm" {
  alias = "provider_sub_online"
  subscription_id = azurerm_subscription.sub_online.id
  features {}
}
provider "azurerm" {
  alias = "provider_sub_security"
  subscription_id = azurerm_subscription.sub_security.id
  features {}
}