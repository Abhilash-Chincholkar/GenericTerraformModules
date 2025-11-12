resource "azurerm_storage_account" "storage_account" {
  for_each                 = var.storage_accounts
  # Required arguments
  name                     = each.value.stg_name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

  # Optional arguments with defaults
  account_kind                      = lookup(each.value, "account_kind", "StorageV2")
  access_tier                       = lookup(each.value, "access_tier", null)
  https_traffic_only_enabled        = lookup(each.value, "https_traffic_only_enabled", true)
  min_tls_version                   = lookup(each.value, "min_tls_version", "TLS1_2")
  cross_tenant_replication_enabled  = lookup(each.value, "cross_tenant_replication_enabled", false)
  allow_nested_items_to_be_public   = lookup(each.value, "allow_nested_items_to_be_public", true)
  shared_access_key_enabled         = lookup(each.value, "shared_access_key_enabled", true)
  public_network_access_enabled     = lookup(each.value, "public_network_access_enabled", true)
  default_to_oauth_authentication   = lookup(each.value, "default_to_oauth_authentication", false)
  is_hns_enabled                    = lookup(each.value, "is_hns_enabled", false)
  nfsv3_enabled                     = lookup(each.value, "nfsv3_enabled", false)
  large_file_share_enabled          = lookup(each.value, "large_file_share_enabled", false)
  infrastructure_encryption_enabled = lookup(each.value, "infrastructure_encryption_enabled", false)
  local_user_enabled                = lookup(each.value, "local_user_enabled", true)
  sftp_enabled                      = lookup(each.value, "sftp_enabled", false)
  dns_endpoint_type                 = lookup(each.value, "dns_endpoint_type", "Standard")
  edge_zone                         = lookup(each.value, "edge_zone", null)
  provisioned_billing_model_version = lookup(each.value, "provisioned_billing_model_version", null)
  allowed_copy_scope                = lookup(each.value, "allowed_copy_scope", null)


  # Optional nested blocks
  dynamic "identity" {
    for_each = lookup(each.value, "identity", null) == null ? [] : [each.value.identity]
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "network_rules" {
    for_each = lookup(each.value, "network_rules", null) == null ? [] : [each.value.network_rules]
    content {
      default_action             = network_rules.value.default_action
      bypass                     = lookup(network_rules.value, "bypass", null)
      ip_rules                   = lookup(network_rules.value, "ip_rules", null)
      virtual_network_subnet_ids  = lookup(network_rules.value, "virtual_network_subnet_ids", null)

      dynamic "private_link_access" {
        for_each = lookup(network_rules.value, "private_link_access", [])
        content {
          endpoint_resource_id = private_link_access.value.endpoint_resource_id
          endpoint_tenant_id   = lookup(private_link_access.value, "endpoint_tenant_id", null)
        }
      }
    }
  }

  dynamic "customer_managed_key" {
    for_each = lookup(each.value, "customer_managed_key", null) == null ? [] : [each.value.customer_managed_key]
    content {
      user_assigned_identity_id = customer_managed_key.value.user_assigned_identity_id
      key_vault_key_id          = lookup(customer_managed_key.value, "key_vault_key_id", null)
      managed_hsm_key_id        = lookup(customer_managed_key.value, "managed_hsm_key_id", null)
    }
  }

  dynamic "routing" {
    for_each = lookup(each.value, "routing", null) == null ? [] : [each.value.routing]
    content {
      publish_internet_endpoints  = lookup(routing.value, "publish_internet_endpoints", false)
      publish_microsoft_endpoints = lookup(routing.value, "publish_microsoft_endpoints", false)
      choice                      = lookup(routing.value, "choice", "MicrosoftRouting")
    }
  }

  dynamic "static_website" {
    for_each = lookup(each.value, "static_website", null) == null ? [] : [each.value.static_website]
    content {
      index_document    = lookup(static_website.value, "index_document", null)
      error_404_document = lookup(static_website.value, "error_404_document", null)
    }
  }

  dynamic "blob_properties" {
    for_each = lookup(each.value, "blob_properties", null) == null ? [] : [each.value.blob_properties]
    content {
      versioning_enabled        = lookup(blob_properties.value, "versioning_enabled", false)
      last_access_time_enabled  = lookup(blob_properties.value, "last_access_time_enabled", false)
      change_feed_enabled       = lookup(blob_properties.value, "change_feed_enabled", false)
      default_service_version   = lookup(blob_properties.value, "default_service_version", null)
    }
  }

  tags = lookup(each.value, "tags", {})
}


