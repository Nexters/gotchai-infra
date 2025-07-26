resource "aws_db_instance" "this" {
  identifier              = var.name
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.username
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = true
  publicly_accessible     = var.publicly_accessible
  manage_master_user_password = true
  db_name                 = var.db_name
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = [var.subnet_id]
} 