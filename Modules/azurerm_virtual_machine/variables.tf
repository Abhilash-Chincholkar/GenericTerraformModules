variable "vms" {
    type = map(object({
        subnet_name = string
        virtual_network_name= string
        resource_group_name = string
        nic_name = string
        location = string
        pip_name = string
        vm_name = string
        vm_size = string
        # admin_username = string
        # admin_password = string
        os_disk = map(string)
        source_image_reference = map(string)
        kv_name = string

 } ))
}
