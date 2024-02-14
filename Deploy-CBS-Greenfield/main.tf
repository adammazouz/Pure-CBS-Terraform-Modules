terraform {
  required_providers {
    cbs = {
      source  = "PureStorage-OpenConnect/cbs"
      version = "~> 0.9.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
  required_version = ">= 0.13"
}

 /*    If Authintication via Service Principles would be used: 
    1. Uncomment the required params from main.tf and variables.tf 
    2. Add your service principle in terraform.tfvars              */

provider "azurerm" {
  features {}
  # client_id       = var.azure_client_id
  # client_secret   = var.azure_client_secret
  # tenant_id       = var.azure_tenant_id
  # subscription_id = var.azure_subscription_id
}

provider "cbs" {
  azure {
    # client_id       = var.azure_client_id
    # client_secret   = var.azure_client_secret
    # tenant_id       = var.azure_tenant_id
    # subscription_id = var.azure_subscription_id
  }
}

resource "azurerm_marketplace_agreement" "plan" {
    publisher = "purestoragemarketplaceadmin"
    offer = "pure_storage_cloud_block_store_deployment"
    plan = var.plan_name
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

module "CBS-Key-Vault" {
  source                  = "../Modules/CBS-Key-Vault"
  resource_group_name     = azurerm_resource_group.azure_rg.name
  resource_group_location = var.resource_group_location
}

module "CBS-Identity" {
  source                  = "../Modules/CBS-Identity"
  resource_group_name     = azurerm_resource_group.azure_rg.name
  resource_group_location = var.resource_group_location
  cbs_vnet_id             = module.CBS_vNET.cbs_vnet_id
  depends_on = [ azurerm_resource_group.azure_rg ]
}

module "CBS-VNET-Peering" {
  source                         = "../Modules/CBS-VNet-Peering"
  resource_group_name            = azurerm_resource_group.azure_rg.name
  cbs_vnet_id                    = module.CBS_vNET.cbs_vnet_id
  cbs_vnet_name                  = module.CBS_vNET.cbs_vnet_name
  azure_virtualnetwork_peer_name = var.azure_virtualnetwork_peer_name
  azure_virtualnetwork_peer_rg   = var.azure_virtualnetwork_peer_rg
}

module "CBS-Array" {
  source                  = "../Modules/CBS-Array"
  array_name              = var.array_name
  resource_group_name     = azurerm_resource_group.azure_rg.name
  resource_group_location = var.resource_group_location
  cbs_vnet_id             = module.CBS_vNET.cbs_vnet_id
  cbs_subnet_mgmt_name    = module.CBS_vNET.azure_subnet_name.cbs_subnet_mgmt
  cbs_subnet_iscsi_name   = module.CBS_vNET.azure_subnet_name.cbs_subnet_iscsi
  cbs_subnet_repl_name    = module.CBS_vNET.azure_subnet_name.cbs_subnet_repl
  cbs_subnet_sys_name     = module.CBS_vNET.azure_subnet_name.cbs_subnet_sys
  license_key             = var.license_key
  cbs_key_vault           = module.CBS-Key-Vault.cbs_key_vault_id
  log_sender_domain       = var.log_sender_domain
  alert_recipients        = var.alert_recipients
  array_model             = var.array_model
  zone                    = var.zone
  key_file_path           = var.key_file_path
  jit_group_ids           = var.jit_group_ids
  tags                    = var.tags
  user_assigned_identity  = module.CBS-Identity.user_assigned_identity_id
  depends_on = [ module.CBS-Identity ]

}
