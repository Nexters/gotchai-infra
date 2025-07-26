module "elb" {
  source = "terraform-aws-modules/elb/aws"

  name            = var.name
  subnets         = var.subnet_ids
  security_groups = var.security_group_ids
  internal        = var.is_internal
  listener        = var.listener
  health_check    = var.health_check

  instances = var.instance_ids
  number_of_instances = length(var.instance_ids)

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}
