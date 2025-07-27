include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/ecr"
}

dependency "github-actions-iam" {
  config_path = "../../github-actions/iam"
  mock_outputs = {
    arn = "arn:aws:iam::123456789012:user/github-actions"
  }
}

inputs = {
  name = "gotchai-dev-server"
  access_arns = [dependency.github-actions-iam.outputs.arn]
}
