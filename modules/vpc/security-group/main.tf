module "security-group" {
  source = "terraform-aws-modules/security-group/aws"

  name                     = var.name
  vpc_id                   = var.vpc_id
  ingress_with_cidr_blocks = var.ingress
  egress_with_cidr_blocks  = var.egress

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}
