variable "vm_template_metadata" {
  description = "Holds the Proxmox VM template metadata for reference"
  type        = map(any)
}

variable "vm_config" {
  description = "Holds the Proxmox VM configuration"
  type        = map(any)
}