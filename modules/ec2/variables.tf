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

variable "env" {
  type = string
}
