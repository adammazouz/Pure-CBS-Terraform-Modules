output "cbs_vnet_name" {
  value = module.CBS_vNET.cbs_vnet_name
}

output "cbs_subnet_mgmt_name" {
  value = module.CBS_vNET.azure_subnet_id.cbs_subnet_mgmt
}

output "cbs_subnet_iscsi_name" {
  value = module.CBS_vNET.azure_subnet_id.cbs_subnet_iscsi
}

output "cbs_subnet_repl_name" {
  value = module.CBS_vNET.azure_subnet_id.cbs_subnet_repl
}

output "cbs_subnet_sys_id" {
  value = module.CBS_vNET.azure_subnet_id.cbs_subnet_sys
}

output "cbs_subnet_vms_name" {
  value = module.CBS_vNET.azure_subnet_id.cbs_subnet_vms
}