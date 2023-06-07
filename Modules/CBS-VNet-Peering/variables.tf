variable "resource_group_name" {
    type        = string
    description = "RG name in Azure"
}


variable "tags" {
  type        = map(string)
  description = "Tags used for the deployment"
  default = {
    "Environment" = "Lab"
    "Owner"       = "CBS"
  }
}

variable "cbs_vnet_id" {
    type        = string
  
}

variable "cbs_vnet_name" {
    type        = string
  
}

variable "azure_virtualnetwork_peer_name" {
  type = string
}

variable "azure_virtualnetwork_peer_rg" {
  type = string
}
