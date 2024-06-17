# #Account info
# variable "enrollment_account_name" {type = string}
# variable "billing_profile_name" {type = string}
# variable "invoice_section_name" {type = string}
# variable "billing_account_name" {type = string}

#Subscriptions
# variable "subscription_management_name" {type = string}
# variable "subscription_identity_name" {type = string}
# variable "subscription_connectivity_name" {type = string}
# variable "subscription_security_name" {type = string}
# variable "subscription_application_name" {type = string}
# variable "subscription_online_name" {type = string}

#Existing Subscriptions
#Managenent
variable "subscription_management_id" {type = string}
#Identity
variable "subscription_identity_id" {type = string}
#Connectivity
variable "subscription_connectivity_id" {type = string}
#Security
variable "subscription_security_id" {type = string}
#Application
variable "subscription_application_id" {type = string}
#Online
variable "subscription_online_id" {type = string}

#Management group
variable "mg_decommissioned_name" {type = string}
variable "mg_management_name" {type = string}
variable "mg_identity_name" {type = string}
variable "mg_connectivity_name" {type = string}
variable "mg_security_name" {type = string}
variable "mg_corp_name" {type = string}
variable "mg_online_name" {type = string}
variable "mg_sandbox_name" {type = string}
variable "mg_parent_name" {type = string}
variable "mg_platform_name" {type = string}
variable "mg_landing_zone_name" {type = string}

#Backend
#Storage container for state files
variable "rg_tfstate_name" {type = string}
variable "rg_tfstate_location" {type = string}
variable "sa_tfstate_name" {type = string}
variable "sa_tfstate_tier" {type = string}
variable "sa_tfstate_replication_type_name" {type = string}
variable "sa_tfstate_container_name" {type = string}
variable "sa_tfstate_container_access_type" {type = string}
variable "sa_tfstate_subscription_id" {type = string}

#Managed Instance
variable "sp_tenant_id" {type = string}
variable "sp_client_id" {type = string}
variable "sp_client_secret" {
    type = string
    sensitive   = true
    }

#Virtual Networks components
variable "rg_nw_name" {type = string}
variable "rg_nw_location" {type = string}
variable "nsg_name" {type = string}
variable "vnet_name" {type = string}

