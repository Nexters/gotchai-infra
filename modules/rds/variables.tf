variable "name" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
  sensitive = true
}

variable "allocated_storage" {
  type = number
}

variable "storage_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
  default = []
}

variable "publicly_accessible" {
  type = bool
  default = false
} 

variable "env" {
  type = string
  validation {
    condition = contains(["dev", "prod"], var.env)
    error_message = "Invalid env value. Allowed values are: dev, prod."
  }
}