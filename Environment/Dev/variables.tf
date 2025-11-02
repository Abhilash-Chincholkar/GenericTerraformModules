variable "resource_groups" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}

variable "virtual_networks" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = optional(map(string))
    subnets = optional(list(object({
      name             = string
      address_prefixes = list(string)
    })), [])
  }))
}


variable "public_ips" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    tags                = optional(map(string))
  }))
}

variable "vms" {
  type = map(object({
    subnet_name            = string
    virtual_network_name   = string
    resource_group_name    = string
    nic_name               = string
    location               = string
    pip_name               = string
    vm_name                = string
    vm_size                = string
    # admin_username         = string
    # admin_password         = string
    os_disk = map(string)
    source_image_reference = map(string)
    kv_name = string

  }))
}


variable "key_vaults" {
  type = map(object({
    kv_name             = string
    location            = string
    resource_group_name = string
  }))
}