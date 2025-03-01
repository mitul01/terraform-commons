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

resource "linode_instance" "k8s-express--master" {
  label           = "k8s-express-master"
  image           = "linode/ubuntu22.04"
  region          = "us-central"
  type            = "g6-standard-1"
  authorized_keys = var.ssh_public_keys
  root_pass       = var.linode_vm_password

  tags       = ["k8s-express"]
}