module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier             = var.identifier
  engine                 = var.engine
  major_engine_version   = var.major_engine_version
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  username               = var.username
  family                 = var.family
  subnet_ids             = var.subnet_ids
  deletion_protection    = true
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = var.publicly_accessible

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}
