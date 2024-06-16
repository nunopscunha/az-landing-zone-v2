#Account info
variable "enrollment_account_name" {type = string}
variable "billing_profile_name" {type = string}
variable "invoice_section_name" {type = string}
variable "billing_account_name" {type = string}

#Subscriptions
variable "subscription_management_name" {type = string}
variable "subscription_identity_name" {type = string}
variable "subscription_connectivity_name" {type = string}
variable "subscription_security_name" {type = string}
variable "subscription_application_name" {type = string}
variable "subscription_online_name" {type = string}

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
