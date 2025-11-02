output "resource_group_ids" {
  description = "Map of resource group ids keyed by for_each key"
  value       = { for k, rg in azurerm_resource_group.resource_group : k => rg.id }
}