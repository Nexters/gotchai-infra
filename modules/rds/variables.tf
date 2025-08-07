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

variable "allocated_storage" {
  type = number
}

variable "db_name" {
  type = string
}

variable "username" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
  default = []
}

variable "is_password_rotation" {
  type = bool
  default = true
}

variable "password_rotation_period" {
  type = number
  default = 7
}

variable "is_public" {
  type    = bool
  default = false
}

variable "env" {
  type = string

  validation {
    condition = contains(["global", "dev", "prod"], var.env)
    error_message = "Invalid env value. Allowed values are: global, dev, prod."
  }
}
