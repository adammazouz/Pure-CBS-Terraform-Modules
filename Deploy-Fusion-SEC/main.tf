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

provider "azurerm" {
  features {}
  # client_id       = var.azure_client_id
  # client_secret   = var.azure_client_secret
  # tenant_id       = var.azure_tenant_id
  # subscription_id = var.azure_subscription_id
}

provider "cbs" {
  azure {
    #     client_id       = var.azure_client_id
    # client_secret   = var.azure_client_secret
    # tenant_id       = var.azure_tenant_id
    # subscription_id = var.azure_subscription_id
  }
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

module "Fusion_SEC" {
  source                     = "../Modules/Fusion-SEC"
  resource_group_name        = azurerm_resource_group.azure_rg.name
  resource_group_location    = var.resource_group_location
  zone                       = var.zone
  tags                       = var.tags
  load_balancer_network_rg   = azurerm_resource_group.azure_rg.name
  load_balancer_network_name = module.CBS_vNET.cbs_vnet_name
  load_balancer_subnet       = module.CBS_vNET.azure_subnet_name.cbs_subnet_iscsi
  jit_group_ids              = var.jit_group_ids

}