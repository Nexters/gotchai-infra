variable "name" {
  type = string
}

variable "acl" {
  type = string

  validation {
    condition = contains(["private", "public-read", "public-read-write"], var.acl)
    error_message = "Invalid condition value. Allowed values are: private, public-read, public-read-write."
  }
}

variable "control_object_ownership" {
  type = bool
}

variable "object_ownership" {
  type = string
}

variable "enable_version" {
  type = bool
  default = false
}

variable "env" {
  type = string

  validation {
    condition = contains(["global", "dev", "prod"], var.env)
    error_message = "Invalid env value. Allowed values are: global, dev, prod."
  }
}
