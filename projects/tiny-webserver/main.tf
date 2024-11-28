terraform {
  required_version = "~> 1.0"
  backend "remote" {
    organization = "empty-minds"

    workspaces {
      name = "tiny-webserver"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.99.0"
    }
  }
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}

provider "aws" {
  region     = "us-east-2"
  access_key = data.hcp_vault_secrets_app.testbed.secrets.aws_access_key
  secret_key = data.hcp_vault_secrets_app.testbed.secrets.aws_secret_key
}

module "aws_asg_elb_cluster" {
  source            = "github.com/mitul01/terraform-commons//modules/giaws-asg-elb-cluster?ref=main"
  project_name      = "tiny-webserver"
  image_id          = "ami-0fb653ca2d3203ac1"
  ec2_instance_type = "t2.micro"
  asg_min_size      = 1
  asg_max_size      = 2
}