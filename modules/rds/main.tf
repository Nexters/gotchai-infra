locals {
  major_engine_version = join(".", slice(split(".", var.engine_version), 0, 2))
}

module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier             = var.name
  engine                 = var.engine
  engine_version         = var.engine_version
  major_engine_version   = local.major_engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  username               = var.username
  create_db_subnet_group = true
  family = join("", [var.engine, local.major_engine_version])
  subnet_ids             = var.subnet_ids
  vpc_security_group_ids = var.security_group_ids
  publicly_accessible    = var.is_public
  manage_master_user_password_rotation = var.is_password_rotation
  master_user_password_rotation_automatically_after_days = var.password_rotation_period
  deletion_protection    = true

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}
