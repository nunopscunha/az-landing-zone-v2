###################################################################
# Get the current client configuration from the AzureRM provider.
###################################################################

data "azurerm_client_config" "core" {}

###################################################################
# This configuration is used to populate the root_parent_id variable with the
###################################################################
data "azurerm_subscription" "current" {}

###################################################################
# Generate random text 
###################################################################
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg-tfstate.name
  }

  byte_length = 5
}

###################################################################
#Existing subscriptions
###################################################################

data "azurerm_subscription" "sub_management" {
  subscription_id = var.subscription_management_id  
}
data "azurerm_subscription" "sub_identity" {
  subscription_id = var.subscription_identity_id  
}
data "azurerm_subscription" "sub_connectivity" {
  subscription_id = var.subscription_connectivity_id
}
data "azurerm_subscription" "sub_security" {
  subscription_id = var.subscription_security_id
}
data "azurerm_subscription" "sub_application" {
  subscription_id = var.subscription_application_id
}
data "azurerm_subscription" "sub_online" {
  subscription_id = var.subscription_online_id 
}

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
  subscription_id     = "/subscriptions/${data.azurerm_subscription.sub_management.subscription_id}"
  
  depends_on = [ 
    azurerm_management_group.mg_management,
    data.azurerm_subscription.sub_management 
    ]
}

resource "azurerm_management_group_subscription_association" "suba_identity" {
  management_group_id = azurerm_management_group.mg_identity.id
  subscription_id     = "/subscriptions/${data.azurerm_subscription.sub_identity.subscription_id}"

  depends_on = [ 
    azurerm_management_group.mg_identity,
    data.azurerm_subscription.sub_identity 
    ]
}

resource "azurerm_management_group_subscription_association" "suba_connectivity" {
  management_group_id = azurerm_management_group.mg_connectivity.id
  subscription_id     = "/subscriptions/${data.azurerm_subscription.sub_connectivity.subscription_id}"

  depends_on = [ 
    azurerm_management_group.mg_connectivity,
    data.azurerm_subscription.sub_connectivity
    ]
}

resource "azurerm_management_group_subscription_association" "suba_security" {
  management_group_id = azurerm_management_group.mg_security.id
  subscription_id     = "/subscriptions/${data.azurerm_subscription.sub_security.subscription_id}"

  depends_on = [ 
    azurerm_management_group.mg_security,
    data.azurerm_subscription.sub_security 
    ]
}

resource "azurerm_management_group_subscription_association" "suba_application" {
  management_group_id = azurerm_management_group.mg_corp.id
  subscription_id     = "/subscriptions/${data.azurerm_subscription.sub_application.subscription_id}"

  depends_on = [ 
    azurerm_management_group.mg_landing_zone,
    data.azurerm_subscription.sub_application 
    ]
}

resource "azurerm_management_group_subscription_association" "suba_online" {
  management_group_id = azurerm_management_group.mg_online.id
  subscription_id     = "/subscriptions/${data.azurerm_subscription.sub_online.subscription_id}"

  depends_on = [ 
    azurerm_management_group.mg_online,
    data.azurerm_subscription.sub_online 
    ]
}

###################################################################
#Create storage account container for state files
###################################################################

# #RG
# resource "azurerm_resource_group" "rg-tfstate" {
#   provider = azurerm.provider_sub_management
#   location = var.rg_tfstate_location
#   name     = var.rg_tfstate_name
#   depends_on = [ data.azurerm_subscription.sub_management ]
# }

# #SA
# resource "azurerm_storage_account" "sa-tfstate" {
#   provider = azurerm.provider_sub_management
#   name                     = "${var.sa_tfstate_name}${random_id.random_id.hex}"
#   resource_group_name      = var.rg_tfstate_name
#   location                 = var.rg_tfstate_location
#   account_tier             = var.sa_tfstate_tier
#   account_replication_type = var.sa_tfstate_replication_type_name

#   depends_on = [ azurerm_resource_group.rg-tfstate ]

#   timeouts {
#         create = "30m"
#         read = "3m"
#         update = "30m"
#         delete = "30m"
#     }
# }

# #container
# resource "azurerm_storage_container" "tfstate" {
#   provider = azurerm.provider_sub_management
#   name                  = var.sa_tfstate_container_name
#   storage_account_name  = azurerm_storage_account.sa-tfstate.name
#   container_access_type = var.sa_tfstate_container_access_type

#   depends_on = [ azurerm_storage_account.sa-tfstate ]
# }

###################################################################
#Create vnets
###################################################################

#RG
resource "azurerm_resource_group" "rg-nw" {
  provider = azurerm.provider_sub_connectivity
  location = var.rg_nw_location
  name     = var.rg_nw_name
  depends_on = [ data.azurerm_subscription.sub_connectivity ]
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg-nw.location
  resource_group_name = azurerm_resource_group.rg-nw.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg-nw.location
  resource_group_name = azurerm_resource_group.rg-nw.name
  address_space       = ["10.0.0.0/16"]
  #dns_servers         = ["10.0.0.4", "10.0.0.5"]

  # subnet {
  #   name           = "subnet1"
  #   address_prefix = "10.0.1.0/24"
  # }

  # subnet {
  #   name           = "subnet2"
  #   address_prefix = "10.0.2.0/24"
  #   security_group = azurerm_network_security_group.nsg.id
  # }

  # tags = {
  #   environment = "Production"
  # }
}