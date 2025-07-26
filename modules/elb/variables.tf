variable "name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
  default = []
}

variable "is_internal" {
  type    = bool
  default = false
}

variable "listener" {
  type = list(object({
    instance_port     = number,
    instance_protocol = string,
    lb_port           = number,
    lb_protocol       = string
  }))
}

variable "health_check" {
  type = object({
    target              = string,
    interval            = number,
    healthy_threshold   = number,
    unhealthy_threshold = number,
    timeout             = number
  })
}

variable "instance_ids" {
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
