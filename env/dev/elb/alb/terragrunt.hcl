include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/elb"
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    vpc_id = "mock-vpc"
    public_subnets = ["mock-public-subnet-1", "mock-public-subnet-2"]
  }
}

dependency "ec2" {
  config_path = "../../server/ec2"
  mock_outputs = {
    instance_ids = ["mock-ec2"]
  }
}

dependency "security_group" {
  config_path = "../security-group"
  mock_outputs = {
    security_group_id = "mock_security_group"
  }
}

inputs = {
  name     = "gotchai-dev"
  subnets  = dependency.vpc.outputs.public_subnets
  security_groups = [dependency.security_group.outputs.security_group_id]
  internal = false
  listener = [
    {
      instance_port     = 8080
      instance_protocol = "HTTP"
      lb_port           = 8080
      lb_protocol       = "HTTP"
    }
  ]
  health_check = {
    target              = "HTTP:8080/ping"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
  insatnces = dependency.ec2.outputs.instance_ids
}
