include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/iam/user"
}

inputs = {
  name = "github-actions"
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
}
