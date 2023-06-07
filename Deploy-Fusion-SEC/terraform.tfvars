
#Azure Variables
resource_group_name     = "Pure-Fusion-" #Prefix for Jump Start Deployment Resources
resource_group_location = "eastus"       #Region see entries below

vnet_address_space = ["10.10.0.0/16"]

subnets = {
  cbs_subnet_mgmt = {
    name             = "cbs_subnet_mgmt"
    address_prefixes = ["10.10.1.0/24"]
  }
  cbs_subnet_iscsi = {
    name             = "cbs_subnet_iscsi"
    address_prefixes = ["10.10.2.0/24"]
  }
  cbs_subnet_repl = {
    name             = "cbs_subnet_repl"
    address_prefixes = ["10.10.3.0/24"]
  }
  cbs_subnet_sys = {
    name             = "cbs_subnet_sys"
    address_prefixes = ["10.10.4.0/24"]
  }
}

tags = {
  "Environment" = "POC"
  "Owner"       = "Fusion"
}

#Azure Zone                  
zone = 1

#Azure AD Group for JIT Approval
jit_group_ids = ["xxxxxxxxxxxxxxx"]

