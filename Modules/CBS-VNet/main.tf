

resource "azurerm_virtual_network" "cbs_virtual_network" {
  name                = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-VNET")
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.cbs_virtual_network.name
  name                 = format("%s%s%s", var.resource_group_name, var.resource_group_location, each.value["name"])
  address_prefixes     = each.value["address_prefixes"]
  service_endpoints    = each.value["name"] == "cbs_subnet_sys" ? ["Microsoft.AzureCosmosDB", "Microsoft.KeyVault"] : []
}
