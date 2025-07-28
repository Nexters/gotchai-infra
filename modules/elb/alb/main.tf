module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name                  = var.name
  vpc_id                = var.vpc_id
  subnets               = var.subnet_ids
  security_groups       = var.security_group_ids
  create_security_group = false
  listeners             = var.listeners
  target_groups         = var.target_groups

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}
