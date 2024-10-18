variable "linode_token" {
  description = "Linode API token"
  type        = string
  default     = ""
}

variable "ssh_public_keys" {
  description = "SSH Public Key"
  type        = list
  default     = [""]
}

variable "linode_vm_password" {
  description = "Linode VM Password"
  type        = string
  default     = ""
}
