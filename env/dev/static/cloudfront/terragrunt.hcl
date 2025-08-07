include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/cloudfront"
}

dependency "zone" {
  config_path = "${get_parent_terragrunt_dir()}/../../global/domain/zone"
  mock_outputs = {
    zone_name = "gotchai-ai.com"
  }
}

dependency "bucket" {
  config_path = "../s3/bucket"
  mock_outputs = {
    domain_name = "gotchai-static.s3.amazonaws.com"
  }
}

dependency "acm" {
  config_path = "${get_parent_terragrunt_dir()}/../../global/certificate/us"
  mock_outputs = {
    arn = "arn:aws:acm:us-east-1:123456789012:certificate/gotchai"
  }
}

inputs = {
  domains     = ["dev-static.gotchai-ai.com"]
  comment     = "gotchai-dev-static"
  price_class = "PriceClass_100"
  zone_name   = dependency.zone.outputs.zone_name
  origins = {
    static_bucket = {
      domain_name           = dependency.bucket.outputs.domain_name
      origin_access_control = "static"
    }
  }
  origin_access_control = {
    "static": {
      "description": "Gotchai web",
      "origin_type": "s3",
      "signing_behavior": "always",
      "signing_protocol": "sigv4"
    }
  }
  default_cache_behavior = {
    target_origin_id       = "static_bucket"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
  }
  certificate_arn = dependency.acm.outputs.arn
}
