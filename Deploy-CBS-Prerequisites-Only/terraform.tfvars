
#Azure Variables
resource_group_name     = "gse-ps-cbs-azure-lab-" #Prefix for Jump Start Deployment Resources
resource_group_location = "eastus"              #Region see entries below

azure_client_id                       = "520b379a-46f5-4713-8460-d2823bd39226"
azure_client_secret                   = "2~98Q~zYZR6gINf2wd54MBlIIue4zsuFh8ck0buZ"
azure_subscription_id                 = "f4c99595-b139-4086-a00c-30da54ce80e9"
azure_tenant_id                       = "5a3d1859-f4b7-4151-beae-773895b989fd"

azure_vm_size     = "Standard_B1s"
azure_vm_username = "pureuser"
azure_vm_password = "F0mFx1Klp0ksQFEfkZX"

# CBS Plan config

plan_name = "cbs_azure_6_6_3" #specify CBS Version 6.1.11 and 6.2.1 are the latest.
plan_product = "pure_storage_cloud_block_store_deployment" #Specify CBS Version
plan_publisher = "purestoragemarketplaceadmin" #specify CBS publisher
plan_version = "1.0.1" #specify CBS Version
#comment
vnet_address_space = ["192.168.176.0/20"]

subnets = {
  cbs_subnet_mgmt = {
    name             = "cbs_subnet_mgmt"
    address_prefixes = ["192.168.177.0/24"]
  }
  cbs_subnet_iscsi = {
    name             = "cbs_subnet_iscsi"
    address_prefixes = ["192.168.178.0/24"]
  }
  cbs_subnet_repl = {
    name             = "cbs_subnet_repl"
    address_prefixes = ["192.168.179.0/24"]
  }
  cbs_subnet_sys = {
    name             = "cbs_subnet_sys"
    address_prefixes = ["192.168.180.0/24"]
  }
}

cbs_subnet_vms = ["192.168.181.0/24"]

#CBS Array Name
array_name = "CBS-Greenfield-GSE-PS-lab"

#CBS License key from Pure1
license_key = "CBS-TRIAL-LICENSE"
#DNS Domain for Array
log_sender_domain = "purestorage.com"
#Email for Alerts
alert_recipients = ["dcave@purestorage.com"]
#Azure Zone
zone = 1
#Array Model ## Choose from (V10MUR1, V20MUR1, V20MP2R2)
array_model = "V10MUR1"

azure_virtualnetwork_peer_name = "GSE_PS_CBS_TF_NET"
azure_virtualnetwork_peer_rg   = "GSE_PS_CBS_TF_NET_RG"

#Azure AD Group for JIT Approval
jit_group_ids = ["eef91524-9f5e-4063-a10f-227270959da7"]
#Private key file path for pureuser
key_file_path = "/home/azureuser/.ssh/gse-ps-cbs-docs-test-array_rsa"

tags = {
  "Environment" = "Lab"
  "Owner"       = "CBS"
}