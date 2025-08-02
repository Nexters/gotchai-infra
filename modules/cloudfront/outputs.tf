output "arn" {
  value = module.cloudfront.cloudfront_distribution_arn
}

output "domain_name" {
  value = module.cloudfront.cloudfront_distribution_domain_name
}

output "zone_id" {
  value = module.cloudfront.cloudfront_distribution_hosted_zone_id
}
