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
  subscription_id = var.subscription_management_id
  features {}
}

# provider "azurerm" {
#   subscription_id = data.azurerm_subscription.sub_management.subscription_id
#   features {}
#   alias = "provider_sub_management"
#   use_cli = false
  
# }
# provider "azurerm" {
#   alias = "provider_sub_application"
#   subscription_id = var.subscription_application_id
#   features {}
# }
# provider "azurerm" {
#   alias = "provider_sub_connectivity"
#   subscription_id = var.subscription_connectivity_id
#   features {}
# }
# provider "azurerm" {
#   alias = "provider_sub_identity"
#   subscription_id = var.subscription_identity_id
#   features {}
# }
# provider "azurerm" {
#   alias = "provider_sub_online"
#   subscription_id = var.subscription_online_id
#   features {}
# }
# provider "azurerm" {
#   alias = "provider_sub_security"
#   subscription_id = var.subscription_security_id
#   features {}
# }