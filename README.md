# Pure-CBS-Terraform-Modules

Terraform examples for deploying Pure Cloud Block Store and Fusion with all the associated pre-requisites

_Note: This repo only supports deploying Cloud Block Store in Azure_

# How to Use

1. Deploy an Azure VM in the same subscription where you are planning to deploy CBS.
2. SSH to the VM, then install Terraform.
3. Authenticate to Azure.
4. Clone this repo.
5. Navigate to the desired example, and edit terraform.tfvars with your own parameters.
6. Run `terraform init`, then `terraform apply`

#\_\_\_

# How it is Built

The content of this repo is mostly Azure and CBS Terraform Provider Code. It is split into:

1. Example dir: `Depoly-*` where you would need to navigate and excite the terraform commands.

   | Example Name                  | Cloud Provider | Modules Used                              |
   | ----------------------------- | -------------- | ----------------------------------------- |
   | Deploy-CBS-Prerequisites-Only | Azure          | CBS-VNET,CBS-NAT-GW, VM-JUMPBOX           |
   | Deploy-CBS-Greenfield         | Azure          | CBS-Array,CBS-VNET,CBS-NAT-GW, VM-JUMPBOX |
   | Deploy-Fusion-SEC             | Azure          | CBS-VNET, Fusion-SEC                                      |
   | [Deploy-Fusion-SEC-with-Two-CBS ](/Deploy-Fusion-with-Two-CBS)        | Azure          | CBS-Array,Fusion-SEC, CBS-VNET,CBS-NAT-GW, VM-JUMPBOX |

2. Modules files:
   | Module Name | |
   | ----------- | --- |
   | CBS-VNET | Creates an Azure VNet with four Subnet |
   | CBS-NAT-GW | Creates an Azure NAT GW and associate it with CBS System Subnet |
   | CBS-Key-Vault | Creates an Azure KeyValut that is used by CBS Terraform Provider to perform management operations |
   | VM-JUMPBOX | Creates an Azure VM on the same CBS VNet, it can be used as a Jump Host or repurpose as an initiator|
   | CBS-Array | Creates a Cloud Block Store Array |
   | Fusion-SEC | Create a Fusion Storage Endpoint Collection |
   | Fusion-CBS-Array | Creates a Cloud Block Store Array that can be associated to a Fusion SEC |
