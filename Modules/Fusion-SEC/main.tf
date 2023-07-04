terraform {
  required_providers {
    cbs = {
      source  = "PureStorage-OpenConnect/cbs"
      version = "~> 0.9.0"
    }
  }
  required_version = ">= 0.13"
}
resource "cbs_fusion_sec_azure" "fusion_sec_azure_instance" {

    fusion_sec_name = format("%s%s%s", var.resource_group_name, var.resource_group_location, "-SEC")

    location = var.resource_group_location
    resource_group_name = var.resource_group_name
    load_balancer_network_rg = var.resource_group_name
    load_balancer_network_name = var.load_balancer_network_name
    load_balancer_subnet = var.load_balancer_subnet

    jit_approval_group_object_ids = var.jit_group_ids
    user_assigned_identity  = var.user_assigned_identity

    plan {
        name = "pure_sec_1_0_0"
        product = "pure_fusion_storage_endpoint_collection" 
        publisher = "purestoragemarketplaceadmin"
        version = "1.0.3"
    }

    tags = var.tags
}
