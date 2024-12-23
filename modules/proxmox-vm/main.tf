resource "proxmox_vm_qemu" "proxmox-vm-from-template" {
    for_each = { for idx,value in var.vm_config["from_templates"] : join(":", [value.name,value.target_node]) => { idx = idx, data = value } }
    name = each.value.data.name
    target_node = each.value.data.target_node
    clone_id = each.value.data.template_id
    vmid = sum([each.value.data.template_id,each.value.idx])
    desc = lookup(each.value.data,"desc",null)
    bios = lookup(each.value.data,"bios",null)
    onboot = lookup(each.value.data,"onboot",null)
    protection = lookup(each.value.data,"protection",null)
    agent = lookup(each.value.data,"enable_qemu_agent",null)
    full_clone = lookup(each.value.data,"full_clone",null)
    memory = contains(keys(each.value.data),"memory") ? lookup(each.value.data.memory,"limits",null) : null
    balloon = contains(keys(each.value.data),"memory") ? lookup(each.value.data.memory,"requests",null) : null
    cores = lookup(each.value.data,"cpu_cores",null)
    tags = lookup(each.value.data,"tags",null)
    ciupgrade = lookup(each.value.data,"upgrade_packages_during_provisioning",null)

    lifecycle {
        precondition {
            condition = contains(keys(each.value.data),"name") && contains(keys(each.value.data),"target_node") && contains(keys(each.value.data),"template_id")
            error_message = "VM's created 'from_template' requires 'name', 'target_node' and 'template_id' attributes."
        }
    }
}