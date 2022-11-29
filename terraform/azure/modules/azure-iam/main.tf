
# # Create app role for F5
# resource "azuread_custom_directory_role" "volterra_azure_app_role" {
#   display_name = var.azure_app_role_name
#   description  = "F5 XC Custom Role to create Azure VNET site"
#   enabled      = true
#   version      = "1.0"

#   permissions {
#     allowed_resource_actions = [
#       "*/read",
#       "*/register/action",
#       "Microsoft.Authorization/roleAssignments/*",
#       "Microsoft.Compute/disks/delete",
#       "Microsoft.Compute/virtualMachineScaleSets/delete",
#       "Microsoft.Compute/virtualMachineScaleSets/write",
#       "Microsoft.Compute/virtualMachines/delete",
#       "Microsoft.Compute/virtualMachines/write",
#       "Microsoft.Marketplace/offerTypes/publishers/offers/plans/agreements/*",
#       "Microsoft.MarketplaceOrdering/agreements/offers/plans/cancel/action",
#       "Microsoft.MarketplaceOrdering/offerTypes/publishers/offers/plans/agreements/write",
#       "Microsoft.Network/loadBalancers/*",
#       "Microsoft.Network/locations/setLoadBalancerFrontendPublicIpAddresses/action",
#       "Microsoft.Network/networkInterfaces/*",
#       "Microsoft.Network/networkSecurityGroups/delete",
#       "Microsoft.Network/networkSecurityGroups/join/action",
#       "Microsoft.Network/networkSecurityGroups/securityRules/delete",
#       "Microsoft.Network/networkSecurityGroups/securityRules/write",
#       "Microsoft.Network/networkSecurityGroups/write",
#       "Microsoft.Network/publicIPAddresses/delete",
#       "Microsoft.Network/publicIPAddresses/join/action",
#       "Microsoft.Network/publicIPAddresses/write",
#       "Microsoft.Network/routeTables/delete",
#       "Microsoft.Network/routeTables/join/action",
#       "Microsoft.Network/routeTables/write",
#       "Microsoft.Network/virtualNetworks/delete",
#       "Microsoft.Network/virtualNetworks/subnets/*",
#       "Microsoft.Network/virtualNetworks/write",
#       "Microsoft.Resources/subscriptions/resourcegroups/*"
#     ]
#   }
# }

data "azurerm_subscription" "primary" {}

# Create new custom Role for Deploy
resource "azurerm_role_definition" "volterra_azure_app_role" {
  name = var.azure_app_role_name
  scope = data.azurerm_subscription.primary.id
  description  = "F5 XC Custom Role to create Azure VNET site"

  permissions {
    actions = [
      "*/read",
      "*/register/action",
      "Microsoft.Authorization/roleAssignments/*",
      "Microsoft.Compute/disks/delete",
      "Microsoft.Compute/virtualMachineScaleSets/delete",
      "Microsoft.Compute/virtualMachineScaleSets/write",
      "Microsoft.Compute/virtualMachines/delete",
      "Microsoft.Compute/virtualMachines/write",
      "Microsoft.Marketplace/offerTypes/publishers/offers/plans/agreements/*",
      "Microsoft.MarketplaceOrdering/agreements/offers/plans/cancel/action",
      "Microsoft.MarketplaceOrdering/offerTypes/publishers/offers/plans/agreements/write",
      "Microsoft.Network/loadBalancers/*",
      "Microsoft.Network/locations/setLoadBalancerFrontendPublicIpAddresses/action",
      "Microsoft.Network/networkInterfaces/*",
      "Microsoft.Network/networkSecurityGroups/delete",
      "Microsoft.Network/networkSecurityGroups/join/action",
      "Microsoft.Network/networkSecurityGroups/securityRules/delete",
      "Microsoft.Network/networkSecurityGroups/securityRules/write",
      "Microsoft.Network/networkSecurityGroups/write",
      "Microsoft.Network/publicIPAddresses/delete",
      "Microsoft.Network/publicIPAddresses/join/action",
      "Microsoft.Network/publicIPAddresses/write",
      "Microsoft.Network/routeTables/delete",
      "Microsoft.Network/routeTables/join/action",
      "Microsoft.Network/routeTables/write",
      "Microsoft.Network/virtualNetworks/delete",
      "Microsoft.Network/virtualNetworks/subnets/*",
      "Microsoft.Network/virtualNetworks/write",
      "Microsoft.Resources/subscriptions/resourcegroups/*"
    ]
    not_actions = []
  }
  assignable_scopes = [
    data.azurerm_subscription.primary.id
  ]
}

# Configure the Azure Active Directory Provider
provider "azuread" {
  tenant_id = var.azure_tenant_id
}

# Create an application
resource "azuread_application" "volterra_azure_app" {
  display_name = var.azuread_application_display_name
}

# Create a service principal
resource "azuread_service_principal" "volterra_azure_app" {
  application_id = azuread_application.volterra_azure_app.application_id
}

# # Attach app role to SP
# resource "azuread_directory_role_assignment" "volterra_azure_app_role_assignment" {
#     role_id = azuread_custom_directory_role.volterra_azure_app_role.object_id
#     principal_object_id = azuread_service_principal.volterra_azure_app.object_id
# }

resource "random_string" "f5_sp_password" {
    length  = 16
    special = true
    keepers = {
        service_principal = "${azuread_service_principal.volterra_azure_app.object_id}"
    }
}

resource "azuread_service_principal_password" "f5_sp_password" {
    service_principal_id = "${azuread_service_principal.volterra_azure_app.object_id}"
    }

# Attach previously created app role to SP
resource "azurerm_role_assignment" "volterra_azure_app_role_assignment" {
    scope = data.azurerm_subscription.primary.id
    role_definition_id = azurerm_role_definition.volterra_azure_app_role.id
    principal_id = azuread_service_principal.volterra_azure_app.object_id
    skip_service_principal_aad_check = true
}