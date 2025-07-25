resource "aws_db_instance" "this" {
  identifier              = var.name
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.username
  password                = var.password
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = true
  publicly_accessible     = var.publicly_accessible
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = [var.subnet_id]
}

resource "null_resource" "create_databases" {
  depends_on = [aws_db_instance.this]

  provisioner "local-exec" {
    command = <<EOT
      mysql -h ${aws_db_instance.this.address} -P ${aws_db_instance.this.port} -u${var.username} -p${var.password} -e "CREATE DATABASE IF NOT EXISTS \`gotchai-dev\`; CREATE DATABASE IF NOT EXISTS \`gotchai-prod\`;"
    EOT
    environment = {
      MYSQL_PWD = var.password
    }
  }
} 