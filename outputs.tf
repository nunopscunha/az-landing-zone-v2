output "subscription_management_name" {
  value = data.azurerm_subscription.sub_management.id
}
output "subscription_identity_name" {
  value = data.azurerm_subscription.sub_identity.id
}
output "subscription_connectivity_name" {
  value = data.azurerm_subscription.sub_connectivity.id
}
output "subscription_security_name" {
  value = data.azurerm_subscription.sub_security.id
}
output "subscription_application_name" {
  value = data.azurerm_subscription.sub_application.id
}
output "subscription_online_name" {
  value = data.azurerm_subscription.sub_online.id
}
output "mg_parent" {
  value = azurerm_management_group.mg_parent.id
}
output "mg_platform_name" {
  value = azurerm_management_group.mg_platform.id
}
output "mg_landing_zone_name" {
  value = azurerm_management_group.mg_landing_zone.id
}
output "mg_decommissioned_name" {
  value = azurerm_management_group.mg_decommissioned.id
}
output "mg_management_name" {
  value = azurerm_management_group.mg_management.id
}
output "mg_identity_name" {
  value = azurerm_management_group.mg_identity.id
}
output "mg_connectivity_name" {
  value = azurerm_management_group.mg_connectivity.id
}
output "mg_security_name" {
  value = azurerm_management_group.mg_security.id
}
output "mg_corp_name" {
  value = azurerm_management_group.mg_corp.id
}
output "mg_online_name" {
  value = azurerm_management_group.mg_online.id
}
output "mg_sandbox_name" {
  value = azurerm_management_group.mg_sandbox.id
}
# output "billing_account" {
#   value = data.azurerm_billing_enrollment_account_scope.acc.id
# }
# output "enrollment_account_name" {
#   value = data.azurerm_billing_mca_account_scope.acc.billing_account_name
# }
# output "billing_account_name" {
#   value = data.azurerm_billing_mca_account_scope.acc.billing_account_name
# }
# output "billing_account_id" {
#   value = data.azurerm_billing_mca_account_scope.acc.id
# }
# output "billing_profile_name" {
#   value = data.azurerm_billing_mca_account_scope.acc.billing_profile_name
# }
# output "invoice_section_name" {
#   value = data.azurerm_billing_mca_account_scope.acc.invoice_section_name
# }
# output "rg_tfstate_name" { value = azurerm_resource_group.rg-tfstate.id}
# output "sa_tfstate_name" { value = azurerm_storage_account.sa-tfstate.id}
# output "sa_tfstate_container_name" { value = azurerm_storage_container.tfstate.id}