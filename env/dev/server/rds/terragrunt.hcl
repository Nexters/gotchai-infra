include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/rds"
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    private_subnet_ids = ["mock-private-subnet-1", "mock-private-subnet-2"]
  }
}

inputs = {
  name              = "gotchai-dev"
  engine            = "mysql"
  engine_version    = "8.4.3"
  instance_class    = "db.t3.micro"
  username          = "gotchai"
  db_name           = "gotchai"
  allocated_storage = 20
  storage_type      = "gp2"
  subnet_ids        = dependency.vpc.outputs.private_subnet_ids
  is_public         = true
}
