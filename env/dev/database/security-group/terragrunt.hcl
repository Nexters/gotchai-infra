include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/vpc/security-group"
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    vpc_id = "gotchai-vpc"
  }
}

# dependency "security-group" {
#   config_path = "../../server/security-group"
#   mock_outputs = {
#     id = "gotchai-security-group"
#   }
# }

inputs = {
  name   = "gotchai-dev-db-sg"
  vpc_id = dependency.vpc.outputs.vpc_id

  ingress = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "TCP"
      cidr_blocks = "0.0.0.0/0"
      # source_security_group_id = dependency.security-group.outputs.id
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
