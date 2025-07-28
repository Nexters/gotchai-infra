variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "listeners" {
  type = any
}

variable "target_groups" {
  type = map(object({
    name_prefix = optional(string)
    protocol    = string
    port        = number
    target_type = string
    target_id = optional(string)
  }))
}

variable "env" {
  type = string

  validation {
    condition = contains(["dev", "prod"], var.env)
    error_message = "Invalid env value. Allowed values are: dev, prod."
  }
}
