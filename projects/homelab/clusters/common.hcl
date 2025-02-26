locals {
  tfc_hostname          = "app.terraform.io" # For TFE, substitute the custom hostname for your TFE host
  tfc_organization      = "empty-minds"
  workspace_name        = reverse(split("/", get_original_terragrunt_dir()))[0]
  environment           = "homelab"
}

generate "remote_state" {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
    terraform {
        backend "remote" {
            hostname = "${local.tfc_hostname}"
            organization = "${local.tfc_organization}"
            workspaces {
                name = "${local.workspace_name}-${local.environment}"
            }
        }
    }
    EOF
}

generate "dependencies" {
    path      = "depedencies.tf"
    if_exists = "overwrite"
    contents  = <<EOF
    data "hcp_vault_secrets_app" "proxmox_secret" {
        app_name = "proxmox"
    }
    data "hcp_vault_secrets_app" "ci_ubuntu_secret" {
        app_name = "ubuntu-vms"
    }
    EOF
}

generate "provider" {
    path      = "providers.tf"
    if_exists = "overwrite"
    contents  = <<EOF
    terraform {
        required_providers {
            proxmox = {
                source = "Telmate/proxmox"
                version = "3.0.1-rc6"
            }
            hcp = {
                source = "hashicorp/hcp"
                version = "0.101.0"
            }
        }
    }
        provider "hcp" {
            client_id     = ""
            client_secret = ""
            project_id    = "2011ab06-4a4a-4b21-985c-0a55421043d1"
        }
        provider "proxmox" {
            pm_api_url          = data.hcp_vault_secrets_app.proxmox_secret.secrets.url
            pm_api_token_id     = data.hcp_vault_secrets_app.proxmox_secret.secrets.token_id
            pm_api_token_secret = data.hcp_vault_secrets_app.proxmox_secret.secrets.token_secret
            pm_tls_insecure     = true
        }
    EOF
}