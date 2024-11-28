variable "project_name" {
  description = "The name of the project used to prefix all the resources"
  type        = string
  default     = ""
}

variable "image_id" {
  description = "The name of the project used to prefix all the resources"
  type        = string
  default     = ""
}

variable "ec2_instance_type" {
  description = "The name of the project used to prefix all the resources"
  type        = string
  default     = ""
}

variable "asg_min_size" {
  description = "The name of the project used to prefix all the resources"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "The name of the project used to prefix all the resources"
  type        = number
  default     = 2
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}



