# Create public IPs
resource "azurerm_public_ip" "jumpbox-public-ip" {
  name                 = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-VM-Public-IP")
  resource_group_name  = var.resource_group_name
    location            = var.resource_group_location
    allocation_method            = "Dynamic"

    tags = {
        environment = "CBS Test"
    }
}
# Create vm subnets
resource "azurerm_subnet" "cbs_subnet_vms" {
  name                 = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-SUBNET-VMS")
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.cbs_vnet_name
  address_prefixes     = var.cbs_subnet_vms_address
}

# Create network interface
resource "azurerm_network_interface" "networkinterface" {
  name                = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-VM-INT")
    location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-VM-IP")
    subnet_id                     = azurerm_subnet.cbs_subnet_vms.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jumpbox-public-ip.id
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "jumpbox-nsg" {
  name                = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-VM-Jumbbox-NSG")
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.networkinterface.id
    network_security_group_id = azurerm_network_security_group.jumpbox-nsg.id
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                            = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-VM")
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  size                            = var.azure_vm_size
  admin_username                  = var.azure_vm_username
  admin_password                  = var.azure_vm_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.networkinterface.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18_04-lts-gen2"
    version   = "latest"
  }
  boot_diagnostics {
  }
}