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

variable "jit_group_ids" {
    type = list(string)
}

variable "zone" {
    type = number
}


variable "load_balancer_network_name" {
    type = string
}
variable "load_balancer_network_rg" {
    type = string
}

variable "load_balancer_subnet" {
  type = string
}
   