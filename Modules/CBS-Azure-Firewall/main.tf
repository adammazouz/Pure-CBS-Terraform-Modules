##################################################
#############         TO DO        ###############
##################################################


resource "azurerm_public_ip" "azure_firewall_ip" {
  name                = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-Firewall-IP")
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
}

resource "azurerm_nat_gateway_public_ip_association" "cbs_pub_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.cbs_nat_gateway.id
  public_ip_address_id = azurerm_public_ip.azure_nat_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "cbs_nat_gateway_association" {
  subnet_id      = var.cbs_system_subnet_id
  nat_gateway_id = azurerm_nat_gateway.cbs_nat_gateway.id
}

#####
resource "azurerm_firewall" "cbs_firewall" {
name                    = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-Firewall")
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Basic"

  ip_configuration {
    name                 = "cbs-firewall-configuration"
    subnet_id            = var.cbs_system_subnet_id
    public_ip_address_id = azurerm_public_ip.azure_firewall_ip.id
  }

tags = var.tags
}

resource "azurerm_firewall_application_rule_collection" "example" {
name                    = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-Application-Firewall")
  azure_firewall_name = azurerm_firewall.cbs_firewall.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Allow"

  rule {
    name = "testrule"

    source_addresses = [
      "10.0.0.0/16",
    ]

    target_fqdns = [
      "*.google.com", 
    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "example" {
  name                = "testcollection"
  azure_firewall_name = azurerm_firewall.example.name
  resource_group_name = azurerm_resource_group.example.name
  priority            = 100
  action              = "Allow"

  rule {
    name = "testrule"

    source_addresses = [
      "10.0.0.0/16",
    ]

    destination_ports = [
      "53",
    ]

    destination_addresses = [
      "8.8.8.8",
      "8.8.4.4",
    ]

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}