include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/ec2"
}

dependency "vpc" {
  config_path = "${get_parent_terragrunt_dir()}/../../global/vpc"
  mock_outputs = {
    public_subnet_ids = ["gotchai-public-subnet-1", "gotchai-public-subnet-2"]
  }
}

dependency "role" {
  config_path = "${get_parent_terragrunt_dir()}/../../global/server/role"
  mock_outputs = {
    instance_profile_name = "gotchai-instance-profile"
  }
}

dependency "security_group" {
  config_path = "../security-group"
  mock_outputs = {
    id = "gotchai-security-group"
  }
}

inputs = {
  name                  = "gotchai-prod-server"
  ami                   = "ami-0f5e205427609c732"
  instance_type         = "t2.micro"
  subnet_id             = dependency.vpc.outputs.public_subnet_ids[0]
  iam_instance_profile  = dependency.role.outputs.instance_profile_name
  is_public             = true
  user_data             = <<-EOF
    #!/bin/bash
    sudo dnf install -y docker
    sudo systemctl enable --now docker
    sudo usermod -aG docker ec2-user
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.6.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  EOF
  key_name              = "gotchai-key"
  security_group_ids    = [dependency.security_group.outputs.id]
  create_security_group = false
}
