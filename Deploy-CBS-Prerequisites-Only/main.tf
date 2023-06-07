terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.70.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  features {}
  # client_id       = var.azure_client_id
  # client_secret   = var.azure_client_secret
  # tenant_id       = var.azure_tenant_id
  # subscription_id = var.azure_subscription_id
}

resource "azurerm_resource_group" "azure_rg" {
  name     = format("%s%s", var.resource_group_name, var.resource_group_location)
  location = var.resource_group_location
  tags     = var.tags
}

module "CBS_vNET" {
  source                  = "../Modules/CBS-VNet"
  resource_group_name     = azurerm_resource_group.azure_rg.name
  resource_group_location = var.resource_group_location
  tags                    = var.tags
}

module "CBS-NAT-GW" {
  source                  = "../Modules/CBS-NAT-GW"
  resource_group_name     = azurerm_resource_group.azure_rg.name
  resource_group_location = var.resource_group_location
  cbs_system_subnet_id    = module.CBS_vNET.azure_subnet_id.cbs_subnet_sys
  tags                    = var.tags
}

module "VM-JUMPBOX" {
  source                  = "../Modules/VM-JUMPBOX"
  resource_group_name     = azurerm_resource_group.azure_rg.name
  resource_group_location = var.resource_group_location
  tags                    = var.tags
  cbs_vnet_name           = module.CBS_vNET.cbs_vnet_name
  cbs_subnet_vms_address  = var.cbs_subnet_vms_address
  azure_vm_size           = var.azure_vm_size
  azure_vm_username       = var.azure_vm_username
  azure_vm_password       = var.azure_vm_password
}




