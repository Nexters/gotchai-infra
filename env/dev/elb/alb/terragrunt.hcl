include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/elb/alb"
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    vpc_id = "gotchai-vpc"
    public_subnet_ids = ["gotchai-public-subnet-1", "mock-public-subnet-2"]
  }
}

dependency "acm" {
  config_path = "../../acm"
  mock_outputs = {
    arn = "arn:aws:acm:ap-northeast-2:123456789012:certificate/gotchai"
  }
}

dependency "ec2" {
  config_path = "../../server/ec2"
  mock_outputs = {
    instance_ids = ["gotchai-instance-1"]
  }
}

dependency "security_group" {
  config_path = "../security-group"
  mock_outputs = {
    id = "gotchai-security-group"
  }
}

inputs = {
  name       = "gotchai-dev-alb"
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.public_subnet_ids
  security_group_ids = [dependency.security_group.outputs.id]
  listeners = {
    server-http = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = 443
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    server-https = {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = dependency.acm.outputs.arn

      forward = {
        target_group_key = "server"
      }
    }
  }
  target_groups = {
    server = {
      name_prefix = "h1"
      protocol    = "HTTP"
      port        = 8080
      target_type = "instance"
      target_id   = dependency.ec2.outputs.instance_ids[0]

      health_check = {
        path     = "/ping"
        port     = "traffic-port"
        protocol = "HTTP"
      }
    }
  }
}
