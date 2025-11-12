variable "storage_accounts" {
  description = "Map of storage accounts to create"
  type = map(object({
    # Required
    stg_name                 = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string

    # Optional
    account_kind                     = optional(string)
    access_tier                      = optional(string)
    https_traffic_only_enabled       = optional(bool)
    min_tls_version                  = optional(string)
    cross_tenant_replication_enabled = optional(bool)
    allow_nested_items_to_be_public  = optional(bool)
    shared_access_key_enabled        = optional(bool)
    public_network_access_enabled    = optional(bool)
    default_to_oauth_authentication  = optional(bool)
    is_hns_enabled                   = optional(bool)
    nfsv3_enabled                    = optional(bool)
    large_file_share_enabled         = optional(bool)
    infrastructure_encryption_enabled = optional(bool)
    local_user_enabled               = optional(bool)
    sftp_enabled                     = optional(bool)
    dns_endpoint_type                = optional(string)
    edge_zone                        = optional(string)
    allowed_copy_scope               = optional(string)
    provisioned_billing_model_version = optional(string)

    # Nested blocks
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))

    network_rules = optional(object({
      default_action            = string
      bypass                    = optional(list(string))
      ip_rules                  = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
      private_link_access = optional(list(object({
        endpoint_resource_id = string
        endpoint_tenant_id   = optional(string)
      })))
    }))

    customer_managed_key = optional(object({
      user_assigned_identity_id = string
      key_vault_key_id          = optional(string)
      managed_hsm_key_id        = optional(string)
    }))

    routing = optional(object({
      publish_internet_endpoints  = optional(bool)
      publish_microsoft_endpoints = optional(bool)
      choice                      = optional(string)
    }))

    static_website = optional(object({
      index_document     = optional(string)
      error_404_document = optional(string)
    }))

    blob_properties = optional(object({
      versioning_enabled       = optional(bool)
      last_access_time_enabled = optional(bool)
      change_feed_enabled      = optional(bool)
      default_service_version  = optional(string)
    }))

    tags = optional(map(string))
  }))
}
