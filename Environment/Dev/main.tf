module "resource_group" {
    source = "../../Modules/azurerm_resource_group"
    resource_groups = var.resource_groups
}

module "virtual_network" {
    depends_on = [ module.resource_group ]
    source = "../../Modules/azurerm_virtual_network"
    virtual_networks = var.virtual_networks  
}

module "public_ip" {
    depends_on = [ module.resource_group ]
    source = "../../Modules/azurerm_public_ip"
    public_ips = var.public_ips
}

module "virtual_machine" {
    depends_on = [ module.virtual_network, module.public_ip ]
    source = "../../Modules/azurerm_virtual_machine"
    vms = var.vms
}

module "keyvault" {
    depends_on = [ module.resource_group ]
    source = "../../Modules/azurerm_keyvalut"
    key_vaults = var.key_vaults
}