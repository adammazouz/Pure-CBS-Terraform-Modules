variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}

variable "resource_group_location" {
  type        = string
  description = "RG location in Azure"
}

# variable "azure_client_id" {
#     type = string
# }
# variable "azure_client_secret" {
#     type = string
# }
# variable "azure_subscription_id" {
#     type = string
# }
# variable "azure_tenant_id" {
#     type = string
# }

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
}

variable "cbs_subnet_vms_address" {
  type        = list(any)
  description = "the address space of the initior VMs subnet"
  default     = ["10.10.0.0/24"]
}

variable "array_name" {
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

variable "azure_virtualnetwork_peer_name" {
  type = string
}

variable "azure_virtualnetwork_peer_rg" {
  type = string
}

variable "zone" {
  type = number
}
variable "log_sender_domain" {
  type = string
}

variable "alert_recipients" {
  type = list(string)
}

variable "jit_group_ids" {
  type = list(string)
}
variable "array_model" {
  type = string
}

variable "license_key" {
  type = string
}

variable "key_file_path" {
  type = string
}

