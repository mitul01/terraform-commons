resource "proxmox_vm_qemu" "proxmox-vm-from-template" {
    for_each = { for idx,value in var.vm_config["from_templates"] : join(":", [value.name,value.target_node]) => value }
    name = each.value.name
    target_node = each.value.target_node
    clone_id = each.value.template_id
    vmid = var.vm_template_metadata.templates[each.value.template_id].id + idx
    desc = lookup(each.value,"desc",null)
    bios = lookup(each.value,"bios",null)
    onboot = lookup(each.value,"onboot",null)
    protection = lookup(each.value,"protection",null)
    agent = lookup(each.value,"enable_qemu_agent",null)
    full_clone = lookup(each.value,"full_clone",null)
    memory = contains(each.value,"memory") ? lookup(each.value.memory,"limits",null) : null
    ballon = contains(each.value,"memory") ? lookup(each.value.memory,"requests",null) : null
    cores = lookup(each.value,"cpu_cores",null)
    tags = lookup(each.value,"tags",null)
    ciupgrade = lookup(each.value,"upgrade_packages_during_provisioning",null)

    lifecycle {
        precondition {
            condition = contains(keys(each.value),"name") && contains(keys(each.value),"target_node") && contains(keys(each.value),"template_id")
            error_message = "VM's created 'from_template' requires 'name', 'target_node' and 'template_id' attributes."
        }
    }
}