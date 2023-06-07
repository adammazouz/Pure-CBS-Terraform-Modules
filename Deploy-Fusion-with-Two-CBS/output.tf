output "VM_Jumpbox_Private_IP" {
  value = module.VM-JUMPBOX.VM_Jumpbox_Private_IP
}

output "VM_Jumpbox_Public_IP" { 
    value = module.VM-JUMPBOX.VM_Jumpbox_Public_IP
}

output "fusion_sec_hmvip0" {
  value = module.Fusion_SEC.fusion_sec_hmvip0
}

output "fusion_sec_hmvip1" {
  value = module.Fusion_SEC.fusion_sec_hmvip1
}

output "fusion_sec_load_balancer_full_identity_id" {
  value = module.Fusion_SEC.fusion_sec_load_balancer_full_identity_id
}