include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/s3/bucket"
}

inputs = {
  name                     = "gotchai-web"
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
}
