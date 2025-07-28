module "acm" {
  source = "terraform-aws-modules/acm/aws"

  domain_name               = var.domain_name
  zone_id                   = var.zone_id
  validation_method         = "DNS"
  subject_alternative_names = var.alternative_names
  wait_for_validation       = true

  tags = {
    CreatedBy = "Terraform"
    Name      = var.domain_name
  }
}
