module "bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket                   = var.name
  acl                      = var.acl
  control_object_ownership = var.control_object_ownership
  object_ownership         = var.object_ownership
  versioning = {
    enabled = var.enable_version
  }

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}
