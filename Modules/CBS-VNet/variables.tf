variable "resource_group_name" {
    type        = string
    description = "RG name in Azure"
}

variable "resource_group_location" {
    type        = string
    description = "RG location in Azure"
}

variable "tags" {
  type        = map(string)
  description = "Tags used for the deployment"
  default = {
    "Environment" = "Lab"
    "Owner"       = "CBS"
  }
}

variable "vnet_address_space" {
  type        = list(any)
  description = "the address space of the VNet"
  default     = ["10.10.0.0/16"]
}

variable "subnets" {
  type = map(any)
  default = {
   cbs_subnet_mgmt = {
      name             = "cbs_subnet_mgmt"
      address_prefixes = ["10.10.1.0/24"]
    }
    cbs_subnet_iscsi = {
      name             = "cbs_subnet_iscsi"
      address_prefixes = ["10.10.2.0/24"]
    }
    cbs_subnet_repl = {
      name             = "cbs_subnet_repl"
      address_prefixes = ["10.10.3.0/24"]
    }
    cbs_subnet_sys = {
      name             = "cbs_subnet_sys"
      address_prefixes = ["10.10.4.0/24"]
    }
  }
}