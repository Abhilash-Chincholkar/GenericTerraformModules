output "virtual_network_ids" {
  description = "Map of virtual_network ids keyed by for_each key"
  value       = { for k, virtual_network in azurerm_virtual_network.virtual_network : k => virtual_network.id }
}