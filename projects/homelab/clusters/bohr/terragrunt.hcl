include {
  path = "${find_in_parent_folders()}"
}

terraform {
  source = "../../../../modules/proxmox-vm"
}

locals {
    vm_template_metadata  = tomap(yamldecode(file("${get_terragrunt_dir()}/config/vm-template-metadata.yaml")))
    vm_config             = tomap(yamldecode(file("${get_terragrunt_dir()}/config/vm-config.yaml")))
}

generate "vars" {
  path      = "variables.auto.tfvars"
  if_exists = "overwrite"
  contents = <<EOF
    vm_template_metadata = ${jsonencode(local.vm_template_metadata)}
    vm_config            = ${jsonencode(local.vm_config)}
    EOF
}