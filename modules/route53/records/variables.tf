variable "zone_name" {
  type = string
}

variable "records" {
  type = list(object({
    name = string
    type = string
    alias = optional(object({
      name    = string
      zone_id = string
    }))
    ttl = optional(number)
    records = optional(list(string))
  }))
}

variable "env" {
  type = string

  validation {
    condition = contains(["global", "dev", "prod"], var.env)
    error_message = "Invalid env value. Allowed values are: global, dev, prod."
  }
}
