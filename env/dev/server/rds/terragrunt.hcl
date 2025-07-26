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

inputs = {
  identifier           = "gotchai-dev"
  engine               = "mysql"
  major_engine_version = "8.4"
  engine_version       = "8.4.3"
  instance_class       = "db.t3.micro"
  family               = "mysql8.4"
  username             = "gotchai"
  db_name              = "gotchai-dev"
  allocated_storage    = 20
  storage_type         = "gp2"
  subnet_ids           = dependency.vpc.outputs.private_subnets
  publicly_accessible  = true
}
