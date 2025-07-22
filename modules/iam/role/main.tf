module "iam-assumable-role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  role_name               = var.role_name
  trusted_role_services   = var.trusted_role_services
  custom_role_policy_arns = var.custom_role_policy_arns
  number_of_custom_role_policy_arns = length(var.custom_role_policy_arns)
  create_role             = true
  create_instance_profile = var.create_instance_profile
  role_requires_mfa       = false

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}
