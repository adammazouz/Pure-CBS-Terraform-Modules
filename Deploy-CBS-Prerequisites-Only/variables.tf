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
    subnet_1 = {
      name             = "subnet_1"
      address_prefixes = ["10.13.1.0/24"]
    }
    subnet_2 = {
      name             = "subnet_2"
      address_prefixes = ["10.13.2.0/24"]
    }
    subnet_3 = {
      name             = "subnet_3"
      address_prefixes = ["10.13.3.0/24"]
    }
    subnet_4 = {
      name             = "subnet_4"
      address_prefixes = ["10.13.4.0/24"]
    }
  }
}

variable "cbs_subnet_vms_address" {
  type        = list(any)
  description = "the address space of the initior VMs subnet"
  default     = ["10.10.0.0/24"]
}

variable "plan_name" {
    type = string
}
variable "azure_vm_size" {
  type = string
}
variable "azure_vm_username" {
  type = string
}
variable "azure_vm_password" {
  type = string
}
variable "key_file_path" {
  type = string
}