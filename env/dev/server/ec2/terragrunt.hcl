include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/ec2"
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs = {
    public_subnet_ids = ["mock-public-subnet-1", "mock-public-subnet-2"]
  }
}

dependency "role" {
  config_path = "../role"
  mock_outputs = {
    instance_profile_name = "mock-instance-profile"
  }
}

dependency "security_group" {
  config_path = "../security-group"
  mock_outputs = {
    security_group_id = "mock_security_group"
  }
}

inputs = {
  name                  = "gotchai-server-dev"
  ami                   = "ami-0f5e205427609c732"
  instance_type         = "t2.micro"
  subnet_id             = dependency.vpc.outputs.public_subnet_ids[0]
  iam_instance_profile  = dependency.role.outputs.instance_profile_name
  is_public             = true
  key_name              = "gotchai-key"
  security_group_ids = [dependency.security_group.outputs.security_group_id]
  create_security_group = false
}
