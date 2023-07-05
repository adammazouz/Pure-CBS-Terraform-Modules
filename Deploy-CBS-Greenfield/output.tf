output "cbs_azure_deployed_plan" {
  value = module.CBS-Array.cbs_azure_deployed_plans
}

output "cbs_mgmt_endpoint" {
  value = module.CBS-Array.cbs_mgmt_endpoint
}
output "cbs_mgmt_endpoint_ct0" {
  value = module.CBS-Array.cbs_mgmt_endpoint_ct0
}
output "cbs_mgmt_endpoint_ct1" {
  value = module.CBS-Array.cbs_mgmt_endpoint_ct1
}
output "cbs_repl_endpoint_ct0" {
  value = module.CBS-Array.cbs_repl_endpoint_ct0
}
output "cbs_repl_endpoint_ct1" {
  value = module.CBS-Array.cbs_repl_endpoint_ct1
}
output "cbs_iscsi_endpoint_ct0" {
  value = module.CBS-Array.cbs_iscsi_endpoint_ct0
}
output "cbs_iscsi_endpoint_ct1" {
  value = module.CBS-Array.cbs_iscsi_endpoint_ct1
}

output "VM_Jumpbox_Private_IP" {
  value = module.VM-JUMPBOX.VM_Jumpbox_Private_IP
}

output "VM_Jumpbox_Public_IP" {
  value = module.VM-JUMPBOX.VM_Jumpbox_Public_IP
}