
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

tags = {
  "Environment" = "Lab"
  "Owner"       = "CBS"
}