data "azurerm_subscription" "primary" {
}

resource "azurerm_user_assigned_identity" "user_identity" {
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  name                = format("%s%s", var.resource_group_name, "user-assigned-identity")
  tags                = var.tags
}

data "azurerm_resource_group" "rg_id" {
  name = var.resource_group_name
}

resource "azurerm_role_definition" "cbs_role" {
  name  = format("%s%s", var.resource_group_name, "cbs-custom-role-definition")
  scope = data.azurerm_resource_group.rg_id.id

  permissions {
    actions     = ["Microsoft.Network/virtualNetworks/subnets/joinViaServiceEndpoint/action"]
    not_actions = []
  }
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = var.cbs_vnet_id
  role_definition_name = azurerm_role_definition.cbs_role.name
  principal_id         = azurerm_user_assigned_identity.user_identity.principal_id
}