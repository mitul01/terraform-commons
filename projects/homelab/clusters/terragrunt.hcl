terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
  }
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

generate = local.common.generate