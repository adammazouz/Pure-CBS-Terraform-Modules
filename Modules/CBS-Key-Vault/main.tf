
data "azurerm_client_config" "client_config" {}

resource "random_id" "vault_id" {
    byte_length = 8
}


resource "azurerm_key_vault" "cbs_key_vault" {
    name                        = "CBS-${random_id.vault_id.hex}"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
    tenant_id                   = data.azurerm_client_config.client_config.tenant_id
    sku_name = "standard"
    access_policy {
        tenant_id          = data.azurerm_client_config.client_config.tenant_id
        object_id          = data.azurerm_client_config.client_config.object_id
        secret_permissions = ["Get", "Set", "Delete", "List", "Recover"]
  }
    tags = var.tags
}