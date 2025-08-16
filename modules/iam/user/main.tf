module "iam_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.60.0"

  name                    = var.name
  policy_arns             = var.policy_arns
  force_destroy           = true
  password_reset_required = false
  create_iam_access_key = false

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}
