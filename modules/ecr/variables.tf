variable "name" {
  type = string
}

variable "access_arns" {
  type = list(string)
  default = []
}

variable "env" {
  type = string

  validation {
    condition = contains(["dev", "prod"], var.env)
    error_message = "Invalid env value. Allowed values are: dev, prod."
  }
}
