output "cbs_vnet_name" {
  value = azurerm_virtual_network.cbs_virtual_network.name
}

output "cbs_vnet_id" {
  value = azurerm_virtual_network.cbs_virtual_network.id
}


output "azure_subnet_id" {
    value = {
        for id in keys(var.subnets) : id => azurerm_subnet.subnet[id].id
    }
    description = "Lists the ID's of the subnets"
}

output "azure_subnet_name" {
    value = {
        for id in keys(var.subnets) : id => azurerm_subnet.subnet[id].name
    }
    description = "Lists the ID's of the subnets"
}
