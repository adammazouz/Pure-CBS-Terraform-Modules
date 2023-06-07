resource "azurerm_public_ip" "azure_nat_ip" {
  name                = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-NAT-IP")
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "cbs_nat_gateway" {
  name                    = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-NAT")
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  tags = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "cbs_pub_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.cbs_nat_gateway.id
  public_ip_address_id = azurerm_public_ip.azure_nat_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "cbs_nat_gateway_association" {
  subnet_id      = var.cbs_system_subnet_id
  nat_gateway_id = azurerm_nat_gateway.cbs_nat_gateway.id
}
