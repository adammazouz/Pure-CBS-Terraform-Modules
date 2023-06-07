output "VM_Jumpbox_Private_IP" {
  value = azurerm_linux_virtual_machine.linux_vm.private_ip_address
}

output "VM_Jumpbox_Public_IP" { 
    value = azurerm_linux_virtual_machine.linux_vm.public_ip_address
}
