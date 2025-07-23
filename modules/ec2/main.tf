module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.0.2"

  name                        = var.name
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  count                       = var.instance_count
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  vpc_security_group_ids      = var.vpc_security_group_ids
  create_security_group       = var.create_security_group

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}
