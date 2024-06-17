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
# provider "azurerm" {
#   alias = "provider_sub_management"
#   subscription_id = var.subscription_management_id
#   tenant_id         = var.sp_tenant_id
#   client_id         = var.sp_client_id
#   client_secret     = var.sp_client_secret
#   features {}
# }
# provider "azurerm" {
#   alias = "provider_sub_application"
#   subscription_id = var.subscription_application_id
#   tenant_id         = var.sp_tenant_id
#   client_id         = var.sp_client_id
#   client_secret     = var.sp_client_secret
#   features {}
# }
# provider "azurerm" {
#   alias = "provider_sub_connectivity"
#   subscription_id = var.subscription_connectivity_id
#   tenant_id         = var.sp_tenant_id
#   client_id         = var.sp_client_id
#   client_secret     = var.sp_client_secret
#   features {}
# }
# provider "azurerm" {
#   alias = "provider_sub_identity"
#   subscription_id = var.subscription_identity_id
#   tenant_id         = var.sp_tenant_id
#   client_id         = var.sp_client_id
#   client_secret     = var.sp_client_secret
#   features {}
# }
# provider "azurerm" {
#   alias = "provider_sub_online"
#   subscription_id = var.subscription_online_id
#   tenant_id         = var.sp_tenant_id
#   client_id         = var.sp_client_id
#   client_secret     = var.sp_client_secret
#   features {}
# }
# provider "azurerm" {
#   alias = "provider_sub_security"
#   subscription_id = var.subscription_security_id
#   tenant_id         = var.sp_tenant_id
#   client_id         = var.sp_client_id
#   client_secret     = var.sp_client_secret
#   features {}
# }