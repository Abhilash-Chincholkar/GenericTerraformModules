data "azurerm_subnet" "subnets" {
    for_each = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "public_ip" {
    for_each = var.vms
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault" "keyvault" {
  for_each = var.vms
  name                = each.value.kv_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "vm_username" {
  for_each    = var.vms
  name         = "vm-username"
  key_vault_id = data.azurerm_key_vault.keyvault[each.key].id
}

data "azurerm_key_vault_secret" "vm_password" {
  for_each    = var.vms
  name         = "vm-password"
  key_vault_id = data.azurerm_key_vault.keyvault[each.key].id
}

resource "azurerm_network_interface" "network_interface" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

 ip_configuration {
      name                          = "internal"
      subnet_id                     = data.azurerm_subnet.subnets[each.key].id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id  = data.azurerm_public_ip.public_ip[each.key].id

  }
}

resource "azurerm_linux_virtual_machine" "virtual_machine" {
    for_each = var.vms
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.vm_size
  # admin_username      = each.value.admin_username
  # admin_password   = each.value.admin_password
  admin_username      = data.azurerm_key_vault_secret.vm_username[each.key].value
  admin_password   = data.azurerm_key_vault_secret.vm_password[each.key].value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.network_interface[each.key].id,
  ]

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }
}
