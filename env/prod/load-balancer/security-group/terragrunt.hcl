include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/vpc/security-group"
}

dependency "vpc" {
  config_path = "${get_parent_terragrunt_dir()}/../../global/vpc"
  mock_outputs = {
    vpc_id = "gotchai-vpc"
  }
}

inputs = {
  name   = "gotchai-prod-alb-sg"
  vpc_id = dependency.vpc.outputs.vpc_id

  ingress = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "TCP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "TCP"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
