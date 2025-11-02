output "public_ip_ids" {
  description = "Map of public ip ids keyed by for_each key"
  value       = { for k, pip in azurerm_public_ip.public_ip : k => pip.id }
}

output "public_ip" {
  description = "Map of public ip adress keyed by for_each key"
  value       = { for k, pip in azurerm_public_ip.public_ip : k => pip.ip_address }
}