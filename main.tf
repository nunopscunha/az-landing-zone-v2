###################################################################
# Get the current client configuration from the AzureRM provider.
###################################################################

data "azurerm_client_config" "core" {}

###################################################################
# This configuration is used to populate the root_parent_id variable with the
###################################################################
data "azurerm_subscription" "current" {}

###################################################################
#Billing info
###################################################################

data "azurerm_billing_mca_account_scope" "acc" {
  billing_account_name = var.billing_account_name
  billing_profile_name = var.billing_profile_name
  invoice_section_name = var.invoice_section_name
}

# data "azurerm_billing_enrollment_account_scope" "acc" {
#   billing_account_name    = var.billing_account_name
#   enrollment_account_name = var.enrollment_account_name
# }

###################################################################
# Generate random text 
###################################################################
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg-tfstate.name
  }

  byte_length = 8
}

# resource "azurerm_resource_provider_registration" "resource_provider_subscription" {
#   name = "Microsoft.Subscription"
# }

###################################################################
#Searching for subscriptions
###################################################################

data "azurerm_subscription" "sub_management" {
  subscription_id = var.subscription_management_id  
}

data "azurerm_subscription" "sub_identity" {
  subscription_id = var.subscription_identity_id  
}

data "azurerm_subscription" "sub_connectivity" {
  subscription_id = va.subscription_connectivity_id
}
data "azurerm_subscription" "sub_security" {
  subscription_id = va.subscription_security_id
}
data "azurerm_subscription" "sub_application" {
  subscription_id = var.subscription_application_id
}
data "azurerm_subscription" "sub_online" {
  subscription_id = var.subscription_online_id 
}

# resource "azurerm_subscription" "sub_management" {
#   subscription_name = var.subscription_management_name
#   billing_scope_id  = data.azurerm_billing_mca_account_scope.acc.id
#   alias =var.subscription_management_name
#   #workload = "DevTest"
#   timeouts {
#       create = "30m"
#       read = "10m"
#       update = "30m"
#       delete = "30m"
#   }
#   #depends_on = [ azurerm_resource_provider_registration.resource_provider_subscription ]
# }

# resource "azurerm_subscription" "sub_identity" {
#   subscription_name = var.subscription_identity_name
#   billing_scope_id  = data.azurerm_billing_mca_account_scope.acc.id
#   alias = var.subscription_identity_name
#   #workload = "DevTest"
#   timeouts {
#       create = "30m"
#       read = "10m"
#       update = "30m"
#       delete = "30m"
#   }
#   depends_on = [ azurerm_management_group_subscription_association.suba_management ]
# }

# resource "azurerm_subscription" "sub_connectivity" {
#   subscription_name = var.subscription_connectivity_name
#   billing_scope_id  = data.azurerm_billing_mca_account_scope.acc.id
#   alias = var.subscription_connectivity_name
#   #workload = "DevTest"
#   timeouts {
#       create = "30m"
#       read = "10m"
#       update = "30m"
#       delete = "30m"
#   }
#   depends_on = [ azurerm_management_group_subscription_association.suba_identity ]
# }

# resource "azurerm_subscription" "sub_security" {
#   subscription_name = var.subscription_security_name
#   billing_scope_id  = data.azurerm_billing_mca_account_scope.acc.id
#   alias = var.subscription_security_name
#   #workload = "DevTest"
#   timeouts {
#       create = "30m"
#       read = "10m"
#       update = "30m"
#       delete = "30m"
#   }
#   depends_on = [ azurerm_management_group_subscription_association.suba_connectivity ]
# }

# resource "azurerm_subscription" "sub_application" {
#   subscription_name = var.subscription_application_name
#   billing_scope_id  = data.azurerm_billing_mca_account_scope.acc.id
#   alias = var.subscription_application_name
#   #workload = "DevTest"
#   timeouts {
#       create = "30m"
#       read = "10m"
#       update = "30m"
#       delete = "30m"
#   }
#   depends_on = [ azurerm_management_group_subscription_association.suba_security ]
# }

# resource "azurerm_subscription" "sub_online" {
#   subscription_name = var.subscription_online_name
#   billing_scope_id  = data.azurerm_billing_mca_account_scope.acc.id
#   alias = var.subscription_online_name
#   #workload = "DevTest"
#   timeouts {
#       create = "30m"
#       read = "10m"
#       update = "30m"
#       delete = "30m"
#   }
#   depends_on = [ azurerm_management_group_subscription_association.suba_connectivity ]
# }

###################################################################
#Creating the management groups
###################################################################

resource "azurerm_management_group" "mg_parent" {
  display_name = var.mg_parent_name
}

resource "azurerm_management_group" "mg_platform" {
  display_name               = var.mg_platform_name
  parent_management_group_id = azurerm_management_group.mg_parent.id
  depends_on = [ azurerm_management_group.mg_parent ]
}

resource "azurerm_management_group" "mg_landing_zone" {
  display_name               = var.mg_landing_zone_name
  parent_management_group_id = azurerm_management_group.mg_parent.id
  depends_on = [ azurerm_management_group.mg_parent ]
}

resource "azurerm_management_group" "mg_decommissioned" {
  display_name               = var.mg_decommissioned_name
  parent_management_group_id = azurerm_management_group.mg_parent.id
  depends_on = [ azurerm_management_group.mg_parent ]
}

resource "azurerm_management_group" "mg_sandbox" {
  display_name               = var.mg_sandbox_name
  parent_management_group_id = azurerm_management_group.mg_parent.id
  depends_on = [ azurerm_management_group.mg_parent ]
}

resource "azurerm_management_group" "mg_management" {
  display_name               = var.mg_management_name
  parent_management_group_id = azurerm_management_group.mg_platform.id
  depends_on = [ azurerm_management_group.mg_platform ]
}

resource "azurerm_management_group" "mg_identity" {
  display_name               = var.mg_identity_name
  parent_management_group_id = azurerm_management_group.mg_platform.id
  depends_on = [ azurerm_management_group.mg_platform ]
}

resource "azurerm_management_group" "mg_connectivity" {
  display_name               = var.mg_connectivity_name
  parent_management_group_id = azurerm_management_group.mg_platform.id
  depends_on = [ azurerm_management_group.mg_platform ]
}

resource "azurerm_management_group" "mg_security" {
  display_name               = var.mg_security_name
  parent_management_group_id = azurerm_management_group.mg_platform.id
  depends_on = [ azurerm_management_group.mg_platform ]
}

resource "azurerm_management_group" "mg_corp" {
  display_name               = var.mg_corp_name
  parent_management_group_id = azurerm_management_group.mg_landing_zone.id
  depends_on = [ azurerm_management_group.mg_landing_zone ]
}

resource "azurerm_management_group" "mg_online" {
  display_name               = var.mg_online_name
  parent_management_group_id = azurerm_management_group.mg_landing_zone.id
  depends_on = [ azurerm_management_group.mg_landing_zone ]
}

###################################################################
#Move subscriptions to the proper management group
###################################################################

resource "azurerm_management_group_subscription_association" "suba_management" {
  management_group_id = azurerm_management_group.mg_management.id
  subscription_id     = "/subscriptions/${azurerm_subscription.sub_management.subscription_id}"
  
  depends_on = [ 
    azurerm_management_group.mg_management,
    azurerm_subscription.sub_management 
    ]
}

resource "azurerm_management_group_subscription_association" "suba_identity" {
  management_group_id = azurerm_management_group.mg_identity.id
  subscription_id     = "/subscriptions/${azurerm_subscription.sub_identity.subscription_id}"

  depends_on = [ 
    azurerm_management_group.mg_identity,
    azurerm_subscription.sub_identity 
    ]
}

resource "azurerm_management_group_subscription_association" "suba_connectivity" {
  management_group_id = azurerm_management_group.mg_connectivity.id
  subscription_id     = "/subscriptions/${azurerm_subscription.sub_connectivity.subscription_id}"

  depends_on = [ 
    azurerm_management_group.mg_connectivity,
    azurerm_subscription.sub_connectivity
    ]
}

resource "azurerm_management_group_subscription_association" "suba_security" {
  management_group_id = azurerm_management_group.mg_security.id
  subscription_id     = "/subscriptions/${azurerm_subscription.sub_security.subscription_id}"

  depends_on = [ 
    azurerm_management_group.mg_security,
    azurerm_subscription.sub_security 
    ]
}

resource "azurerm_management_group_subscription_association" "suba_application" {
  management_group_id = azurerm_management_group.mg_corp.id
  subscription_id     = "/subscriptions/${azurerm_subscription.sub_application.subscription_id}"

  depends_on = [ 
    azurerm_management_group.mg_landing_zone,
    azurerm_subscription.sub_application 
    ]
}

resource "azurerm_management_group_subscription_association" "suba_online" {
  management_group_id = azurerm_management_group.mg_online.id
  subscription_id     = "/subscriptions/${azurerm_subscription.sub_online.subscription_id}"

  depends_on = [ 
    azurerm_management_group.mg_online,
    azurerm_subscription.sub_online 
    ]
}
###################################################################
#Create storage account container for state files
###################################################################

resource "azurerm_resource_group" "rg-tfstate" {
  provider = azurerm.sa_tfstate_subscription
  location = var.rg_tfstate_location
  name     = var.rg_tfstate_name
  depends_on = [ azurerm_subscription.sub_management ]
}

resource "azurerm_storage_account" "sa-tfstate" {
  provider = azurerm.sa_tfstate_subscription
  name                     = "${var.sa_tfstate_name}${random_id.random_id.hex}"
  resource_group_name      = var.rg_tfstate_name
  location                 = var.rg_tfstate_location
  account_tier             = var.sa_tfstate_tier
  account_replication_type = var.sa_tfstate_replication_type_name

  depends_on = [ azurerm_resource_group.rg-tfstate ]

  timeouts {
        create = "30m"
        read = "3m"
        update = "30m"
        delete = "30m"
    }
}

resource "azurerm_storage_container" "tfstate" {
  provider = azurerm.sa_tfstate_subscription
  name                  = var.sa_tfstate_container_name
  storage_account_name  = var.sa_tfstate_name
  container_access_type = var.sa_tfstate_container_access_type

  depends_on = [ azurerm_storage_account.sa-tfstate ]
}