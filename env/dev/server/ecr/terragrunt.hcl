include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/ecr"
}

dependency "github-actions-iam" {
  config_path = "../../github-actions/iam"
  mock_outputs = {
    arn = "mock-arn"
  }
}

inputs = {
  repository_name = "gotchai-server-dev"
  repository_read_write_access_arns = [dependency.github-actions-iam.outputs.arn]
}
