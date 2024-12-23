generate "dependencies" {
    path      = "depedencies.tf"
    if_exists = "overwrite"
    contents  = <<EOF
    data "hcp_vault_secrets_app" "proxmox_secret" {
        app_name = "proxmox"
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
            project_id = "2011ab06-4a4a-4b21-985c-0a55421043d1"
        }
        provider "proxmox" {
            pm_api_url          = data.hcp_vault_secrets_app.proxmox_secret.secrets.url
            pm_api_token_id     = data.hcp_vault_secrets_app.proxmox_secret.secrets.token_id
            pm_api_token_secret = data.hcp_vault_secrets_app.proxmox_secret.secrets.token_secret
            pm_tls_insecure     = true
        }
    EOF
}