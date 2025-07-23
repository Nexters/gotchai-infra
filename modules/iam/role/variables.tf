variable "role_name" {
  type = string
}

variable "trusted_role_services" {
  type = list(string)
}

variable "custom_role_policy_arns" {
  type = list(string)
}

variable "create_instance_profile" {
  type    = bool
  default = false
}

variable "env" {
  type = string

  validation {
    condition = contains(["dev", "prod"], var.env)
    error_message = "Invalid env value. Allowed values are: dev, prod."
  }
}
