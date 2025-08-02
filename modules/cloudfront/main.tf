module "cloudfront" {
  source = "terraform-aws-modules/cloudfront/aws"

  aliases = var.domains
  comment = var.comment
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = var.price_class
  retain_on_delete    = false
  wait_for_deployment = true
  create_origin_access_control = true

  origin = var.origins
  default_cache_behavior = var.default_cache_behavior
  default_root_object = var.default_root_object
  custom_error_response = var.custom_error_responses
  viewer_certificate = {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = "sni-only"
  }

  tags = {
    CreatedBy   = "Terraform"
    Environment = var.env
  }
}

module "records" {
  source = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name
  records = [
    for domain in var.domains : {
      name = domain == var.zone_name ? "" : trimsuffix(domain, ".${var.zone_name}")
      type = "A"
      alias = {
        name    = module.cloudfront.cloudfront_distribution_domain_name
        zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
      }
    }
  ]
}
