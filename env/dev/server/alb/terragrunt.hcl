include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/alb"
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    vpc_id = "mock-vpc"
    public_subnets = ["mock-public-subnet-1", "mock-public-subnet-2"]
  }
}

dependency "security_group" {
  config_path = "../security-group"
  mock_outputs = {
    security_group_id = "mock_security_group"
  }
}

inputs = {
  name                    = "gotchai-alb-dev"
  internal                = false
  security_group_ids      = [dependency.security_group.outputs.security_group_id]
  subnet_ids              = dependency.vpc.outputs.public_subnets
  vpc_id                  = dependency.vpc.outputs.vpc_id
  certificate_arn         = get_env("ACM_CERTIFICATE_ARN", "")
  target_group_port       = 80
  target_group_protocol   = "HTTP"
  health_check_path       = "/"
  enable_deletion_protection = false
} 