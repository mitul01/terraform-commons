resource "proxmox_vm_qemu" "proxmox-vm-from-template" {
  for_each = { for idx, value in var.vm_config["from_templates"] : join(":", [value.name, value.target_node]) => { idx = idx, data = value } }

  name        = each.value.data.name
  target_node = each.value.data.target_node
  clone_id    = each.value.data.template_id
  vmid        = sum([tonumber(each.value.data.template_id), each.value.idx, 1])
  desc        = lookup(each.value.data, "desc", null)
  bios        = lookup(each.value.data, "bios", null)
  onboot      = lookup(each.value.data, "onboot", null)
  boot        = lookup(each.value.data, "boot", null)
  protection  = lookup(each.value.data, "protection", null)
  agent       = lookup(each.value.data, "enable_qemu_agent", null)
  full_clone  = lookup(each.value.data, "full_clone", null)
  memory      = contains(keys(each.value.data), "memory") ? lookup(each.value.data.memory, "limits", null) : null
  balloon     = contains(keys(each.value.data), "memory") ? lookup(each.value.data.memory, "requests", null) : null
  cores       = lookup(each.value.data, "cpu_cores", null)
  tags        = lookup(each.value.data, "tags", null)
  scsihw      = lookup(each.value.data, "scsi_controller_type", null)
  ipconfig0   = lookup(each.value.data, "ipconfig0", null)
  ciuser      = data.hcp_vault_secrets_app.ci_ubuntu_secret.secrets.ciuser
  cipassword  = data.hcp_vault_secrets_app.ci_ubuntu_secret.secrets.cipassword
  sshkeys     = data.hcp_vault_secrets_app.ci_ubuntu_secret.secrets.sshkeys
  ciupgrade   = lookup(each.value.data, "ciupgrade", null)

  dynamic "disks" {
    for_each = contains(keys(each.value.data), "disks") ? [{ "values" : lookup(each.value.data, "disks", []) }] : []
    content {
      dynamic "ide" {
        for_each = length([for d in disks.value.values : d if strcontains(d.id, "ide")]) > 0 ? [{ "values" : [for d in disks.value.values : d if strcontains(d.id, "ide")] }] : []
        content {
          dynamic "ide0" {
            for_each = length([for d in ide.value.values : d if strcontains(d.id, "ide0")]) > 0 ? [{ "values" : [for d in ide.value.values : d if strcontains(d.id, "ide0")] }] : []
            content {
              dynamic "cloudinit" {
                for_each = ide0.value.values[0].type == "cloudinit" ? [1] : []
                content {
                  storage = lookup(ide0.value.values[0], "storage", null)
                }
              }
              dynamic "cdrom" {
                for_each = ide0.value.values[0].type == "cdrom" ? [1] : []
                content {
                  iso         = lookup(ide0.value.values[0], "iso", null)
                  passthrough = lookup(ide0.value.values[0], "passthrough", null)
                }
              }
              dynamic "disk" {
                for_each = ide0.value.values[0].type == "disk" ? [1] : []
                content {
                  size       = lookup(ide0.value.values[0], "size", null)
                  storage    = lookup(ide0.value.values[0], "storage", null)
                  emulatessd = lookup(ide0.value.values[0], "emulatessd", null)
                  discard    = lookup(ide0.value.values[0], "discard", null)
                  backup     = lookup(ide0.value.values[0], "backup", null)
                }
              }
              dynamic "passthrough" {
                for_each = ide0.value.values[0].type == "passthrough" ? [1] : []
                content {
                  file = lookup(ide0.value.values[0], "file", null)
                }
              }
            }
          }
          dynamic "ide1" {
            for_each = length([for d in ide.value.values : d if strcontains(d.id, "ide1")]) > 0 ? [{ "values" : [for d in ide.value.values : d if strcontains(d.id, "ide1")] }] : []
            content {
              dynamic "cloudinit" {
                for_each = ide1.value.values[0].type == "cloudinit" ? [1] : []
                content {
                  storage = lookup(ide1.value.values[0], "storage", null)
                }
              }
              dynamic "cdrom" {
                for_each = ide1.value.values[0].type == "cdrom" ? [1] : []
                content {
                  iso         = lookup(ide1.value.values[0], "iso", null)
                  passthrough = lookup(ide1.value.values[0], "passthrough", null)
                }
              }
              dynamic "disk" {
                for_each = ide1.value.values[0].type == "disk" ? [1] : []
                content {
                  size       = lookup(ide1.value.values[0], "size", null)
                  storage    = lookup(ide1.value.values[0], "storage", null)
                  emulatessd = lookup(ide1.value.values[0], "emulatessd", null)
                  discard    = lookup(ide1.value.values[0], "discard", null)
                  backup     = lookup(ide1.value.values[0], "backup", null)
                }
              }
              dynamic "passthrough" {
                for_each = ide1.value.values[0].type == "passthrough" ? [1] : []
                content {
                  file = lookup(ide1.value.values[0], "file", null)
                }
              }
            }
          }
          dynamic "ide2" {
            for_each = length([for d in ide.value.values : d if strcontains(d.id, "ide2")]) > 0 ? [{ "values" : [for d in ide.value.values : d if strcontains(d.id, "ide2")] }] : []
            content {
              dynamic "cloudinit" {
                for_each = ide2.value.values[0].type == "cloudinit" ? [1] : []
                content {
                  storage = lookup(ide2.value.values[0], "storage", null)
                }
              }
              dynamic "cdrom" {
                for_each = ide2.value.values[0].type == "cdrom" ? [1] : []
                content {
                  iso         = lookup(ide2.value.values[0], "iso", null)
                  passthrough = lookup(ide2.value.values[0], "passthrough", null)
                }
              }
              dynamic "disk" {
                for_each = ide2.value.values[0].type == "disk" ? [1] : []
                content {
                  size       = lookup(ide2.value.values[0], "size", null)
                  storage    = lookup(ide2.value.values[0], "storage", null)
                  emulatessd = lookup(ide2.value.values[0], "emulatessd", null)
                  discard    = lookup(ide2.value.values[0], "discard", null)
                  backup     = lookup(ide2.value.values[0], "backup", null)
                }
              }
              dynamic "passthrough" {
                for_each = ide2.value.values[0].type == "passthrough" ? [1] : []
                content {
                  file = lookup(ide2.value.values[0], "file", null)
                }
              }
            }
          }
        }
      }
      dynamic "scsi" {
        for_each = length([for d in disks.value.values : d if strcontains(d.id, "scsi")]) > 0 ? [{ "values" : [for d in disks.value.values : d if strcontains(d.id, "scsi")] }] : []
        content {
          dynamic "scsi0" {
            for_each = length([for d in scsi.value.values : d if strcontains(d.id, "scsi0")]) > 0 ? [{ "values" : [for d in scsi.value.values : d if strcontains(d.id, "scsi0")] }] : []
            content {
              dynamic "cloudinit" {
                for_each = scsi0.value.values[0].type == "cloudinit" ? [1] : []
                content {
                  storage = lookup(scsi0.value.values[0], "storage", null)
                }
              }
              dynamic "cdrom" {
                for_each = scsi0.value.values[0].type == "cdrom" ? [1] : []
                content {
                  iso         = lookup(scsi0.value.values[0], "iso", null)
                  passthrough = lookup(scsi0.value.values[0], "passthrough", null)
                }
              }
              dynamic "disk" {
                for_each = scsi0.value.values[0].type == "disk" ? [1] : []
                content {
                  size       = lookup(scsi0.value.values[0], "size", null)
                  storage    = lookup(scsi0.value.values[0], "storage", null)
                  emulatessd = lookup(scsi0.value.values[0], "emulatessd", null)
                  discard    = lookup(scsi0.value.values[0], "discard", null)
                  iothread   = lookup(scsi0.value.values[0], "iothread", null)
                  backup     = lookup(scsi0.value.values[0], "backup", null)
                }
              }
              dynamic "passthrough" {
                for_each = scsi0.value.values[0].type == "passthrough" ? [1] : []
                content {
                  file = lookup(scsi0.value.values[0], "file", null)
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "network" {
    for_each = contains(keys(each.value.data), "networks") ? each.value.data.networks : []
    content {
      id       = lookup(network.value, "id", null)
      model    = lookup(network.value, "model", null)
      bridge   = lookup(network.value, "bridge", null)
      firewall = lookup(network.value, "firewall", null)
      rate     = lookup(network.value, "rate", null)
    }
  }

  dynamic "serial" {
    for_each = contains(keys(each.value.data), "serials") ? each.value.data.serials : []
    content {
      id   = lookup(serial.value, "id", null)
      type = lookup(serial.value, "type", null)
    }
  }

  lifecycle {
    precondition {
      condition     = contains(keys(each.value.data), "name") && contains(keys(each.value.data), "target_node") && contains(keys(each.value.data), "template_id")
      error_message = "VM's created 'from_template' requires 'name', 'target_node' and 'template_id' attributes."
    }
  }
}