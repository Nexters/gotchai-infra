include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/ec2"
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = "mock-vpc"
    public_subnets = ["mock-public-subnet-1", "mock-public-subnet-2"]
    private_subnets = ["mock-private-subnet-1", "mock-private-subnet-2"]
  }
}

inputs = {
  name          = "gotchai-dev-container-1"
  ami           = "ami-0662f4965dfc70aca"
  instance_type = "t2.micro"
  subnet_id     = dependency.vpc.outputs.public_subnets[0]
}
