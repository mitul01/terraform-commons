include {
  path = "${find_in_parent_folders()}"
}

terraform {
  #  source = "github.com/mitul01/terraform-commons//modules/proxmox-vm?ref=proxmox-vm-module"
  source = "/Users/mitultandon/myprojects/terraform-commons/modules/proxmox-vm"
}

inputs = {
    vm_template_metadata  = tomap(yamldecode(file("${get_terragrunt_dir()}/config/vm-template-metadata.yaml")))
    vm_config             = tomap(yamldecode(file("${get_terragrunt_dir()}/config/vm-config.yaml")))
}