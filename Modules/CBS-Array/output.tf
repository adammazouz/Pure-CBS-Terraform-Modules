output "cbs_azure_deployed_plans" {
  value = data.cbs_azure_plans.azure_plans.plans
}

output "cbs_mgmt_endpoint" {
  value = cbs_array_azure.azure_instance.management_endpoint
}
output "cbs_mgmt_endpoint_ct0" {
  value = cbs_array_azure.azure_instance.management_endpoint_ct0
}
output "cbs_mgmt_endpoint_ct1" {
  value = cbs_array_azure.azure_instance.management_endpoint_ct1
}
output "cbs_repl_endpoint_ct0" {
  value = cbs_array_azure.azure_instance.replication_endpoint_ct0
}
output "cbs_repl_endpoint_ct1" {
  value = cbs_array_azure.azure_instance.replication_endpoint_ct1
}
output "cbs_iscsi_endpoint_ct0" {
  value = cbs_array_azure.azure_instance.iscsi_endpoint_ct0
}
output "cbs_iscsi_endpoint_ct1" {
  value = cbs_array_azure.azure_instance.iscsi_endpoint_ct1
}