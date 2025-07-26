include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/rds"
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    private_subnets = ["mock-private-subnet-1", "mock-private-subnet-2"]
  }
}

dependency "security_group" {
  config_path = "../security-group"
  mock_outputs = {
    security_group_id = "mock_security_group"
  }
}

inputs = {
  name                   = "gotchai-rds-dev"
  engine                 = "mysql"
  engine_version         = "8.4.3"
  instance_class         = "db.t3.micro"
  username               = "gotchai"
  db_name                = "gotchai-dev"
  allocated_storage      = 20
  storage_type           = "gp2"
  subnet_id              = dependency.vpc.outputs.private_subnets[0]
  vpc_security_group_ids = [dependency.security_group.outputs.security_group_id]
  publicly_accessible    = true
}
