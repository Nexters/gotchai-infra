include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/vpc/security-group"
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    vpc_id = "mock-vpc"
  }
}

inputs = {
  name   = "gotchai-alb-dev"
  vpc_id = dependency.vpc.outputs.vpc_id

  ingress = [
    {
      from_port   = 8080
      to_port     = 8080
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
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "TCP"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
