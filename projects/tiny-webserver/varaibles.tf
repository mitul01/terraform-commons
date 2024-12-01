variable "hcp_client_id" {
  description = "HCP Client Id"
  type        = string
  sensitive   = true
  default     = ""
}

variable "hcp_client_secret" {
  description = "HCP Client Secret"
  type        = string
  sensitive   = true
  default     = ""
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}