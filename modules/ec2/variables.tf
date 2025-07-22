variable "name" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "iam_instance_profile" {
  type     = string
  nullable = true
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "key_name" {
  type     = string
  nullable = true
}

variable "vpc_security_group_ids" {
  type = list(string)
  default = []
}

variable "create_security_group" {
  type    = bool
  default = true
}

variable "env" {
  type = string

  validation {
    condition = contains(["dev", "prod"], var.env)
    error_message = "Invalid env value. Allowed values are: dev, prod."
  }
}
