output "proxmox_vms" {
  value = {
    for key, value in proxmox_vm_qemu.proxmox-vm-from-template : key => value.id
  }
}