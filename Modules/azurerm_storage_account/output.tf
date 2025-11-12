output "stg_account_id" {
  description = "Map of stg account ids keyed by for_each key"
  value       = { for k, stg in azurerm_storage_account.storage_account : k => stg.id }
}