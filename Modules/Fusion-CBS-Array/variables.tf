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
variable "array_name" {
  type = string
}

variable "cbs_vnet_id" {
  type = string
}

variable "cbs_subnet_mgmt_name" {
  type = string
}
variable "cbs_subnet_iscsi_name" {
  type = string
}
variable "cbs_subnet_repl_name" {
  type = string
}

variable "cbs_subnet_sys_name" {
  type = string
}

variable "cbs_key_vault" {
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

variable "fusion_sec_load_balancer_full_identity_id" {
  type = string
}

variable "user_assigned_identity" {
  type = string
}