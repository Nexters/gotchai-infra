module "elb" {
  source = "terraform-aws-modules/elb/aws"

  name            = var.name
  subnets         = var.subnets
  security_groups = var.security_groups
  internal        = var.internal
  listener        = var.listener
  health_check    = var.health_check

  instances = var.instances
  number_of_instances = length(var.instances)

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}
