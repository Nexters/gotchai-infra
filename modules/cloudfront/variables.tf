variable "domains" {
  type = list(string)
}

variable "comment" {
  type = string
  nullable = true
}

variable "price_class" {
  type = string
}

variable "zone_name" {
  type = string
}

variable "origins" {
  type = map(any)
}

variable "default_root_object" {
  type = string
  nullable = true
}

variable "default_cache_behavior" {
  type = any
}

variable "custom_error_responses" {
  type = list(any)
  default = []
}

variable "certificate_arn" {
  type = string
}

variable "env" {
  type = string

  validation {
    condition = contains(["global", "dev", "prod"], var.env)
    error_message = "Invalid env value. Allowed values are: global, dev, prod."
  }
}
