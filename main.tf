resource "azurerm_storage_account" "lab" {
  name                     = "iacsecuritylabdemo123"
  resource_group_name      = azurerm_resource_group.lab.name
  location                 = azurerm_resource_group.lab.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Require HTTPS.
  https_traffic_only_enabled = true

  # Prevent objects from being configured for anonymous access.
  allow_nested_items_to_be_public = false

  # Prefer Entra ID authentication over storage account keys.
  shared_access_key_enabled = false

  default_to_oauth_authentication = true

  # Disable the public network endpoint for this security lab.
  public_network_access_enabled = false

  # Disable cross-tenant replication unless explicitly required.
  cross_tenant_replication_enabled = false

  min_tls_version = "TLS1_2"

  tags = {
    environment = "lab"
    project     = "iac-security"
  }
}