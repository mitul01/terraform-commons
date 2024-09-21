terraform {
  backend "remote" {
    organization = "empty-minds"

    workspaces {
      name = "testbed-linode"
    }
  }
  required_providers {
    linode = {
      source  = "linode/linode"
    }
  }
}

# Configure the Linode Provider
provider "linode" {
  token = var.linode_token
}