include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/route53/zone"
}

inputs = {
  name = "gotchai-ai.com"
}
