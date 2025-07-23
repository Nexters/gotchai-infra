variable "name" {
  type = string
}

variable "cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "subnet_count" {
  type = number

  validation {
    condition     = log(var.subnet_count, 2) % 1 == 0
    error_message = "subnet_count must be a power of 2."
  }
}

variable "enable_nat_gateway" {
  type = bool
}

variable "env" {
  type = string

  validation {
    condition = contains(["dev", "prod"], var.env)
    error_message = "Invalid env value. Allowed values are: dev, prod."
  }
}
