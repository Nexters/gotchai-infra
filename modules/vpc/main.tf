module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name               = var.name
  cidr               = var.cidr
  azs                = var.availability_zones
  public_subnets     = [for i in range(var.subnet_count / 2) : cidrsubnet(var.cidr, log(var.subnet_count, 2), i)]
  private_subnets    = [for i in range(var.subnet_count / 2) :cidrsubnet(var.cidr, log(var.subnet_count, 2), i + (var.subnet_count / 2))]
  enable_nat_gateway = var.enable_nat

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}
