include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/vpc"
}

inputs = {
  name = "gotchai-dev"
  cidr = "192.168.0.0/16"
  azs = [
    "ap-northeast-2a",
    "ap-northeast-2b"
  ]
  subnet_count       = 2
  enable_nat_gateway = false
}
