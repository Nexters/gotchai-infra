variable "domain_name" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "alternative_names" {
  type = list(string)
  default = []
}

variable "region" {
  type = string
  default = "ap-northeast-2"
}
