module "iam_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name                    = var.name
  policy_arns             = var.policy_arns
  force_destroy           = true
  password_reset_required = false

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}
