include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/rds"
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    public_subnet_ids = ["gotchai-private-subnet-1", "gotchai-private-subnet-2"]
  }
}

dependency "security-group" {
  config_path = "../security-group"
  mock_outputs = {
    id = "gotchai-security-group"
  }
}

inputs = {
  name                 = "gotchai-db"
  engine               = "mysql"
  engine_version       = "8.4.3"
  instance_class       = "db.t3.micro"
  username             = "gotchai"
  db_name              = "gotchai"
  allocated_storage    = 20
  storage_type         = "gp2"
  is_public            = true
  subnet_ids           = dependency.vpc.outputs.public_subnet_ids
  security_group_ids   = [dependency.security-group.outputs.id]
  is_password_rotation = false
}
