include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/cloudfront"
}

dependency "zone" {
  config_path = "../../domain/zone"
  mock_outputs = {
    zone_name = "gotchai-ai.com"
  }
}

dependency "bucket" {
  config_path = "../s3/bucket"
  mock_outputs = {
    regional_domain_name = "gotchai-web.s3.ap-northeast-2.amazonaws.com"
  }
}

dependency "acm" {
  config_path = "../../certificate/us"
  mock_outputs = {
    arn = "arn:aws:acm:us-east-1:123456789012:certificate/gotchai"
  }
}

inputs = {
  domains     = ["gotchai-ai.com"]
  comment     = "gotchai-web"
  price_class = "PriceClass_100"
  zone_name   = dependency.zone.outputs.zone_name
  origins = {
    web_bucket = {
      domain_name           = dependency.bucket.outputs.regional_domain_name
      origin_access_control = "web"
    }
  }
  origin_access_control = {
    "web" : {
      "description" : "Gotchai web",
      "origin_type" : "s3",
      "signing_behavior" : "always",
      "signing_protocol" : "sigv4"
    }
  }
  default_root_object = "index.html"
  default_cache_behavior = {
    target_origin_id       = "web_bucket"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }
  custom_error_responses = [
    {
      error_code         = 404
      response_code      = 200
      response_page_path = "/index.html"
    },
    {
      error_code         = 403
      response_code      = 200
      response_page_path = "/index.html"
    }
  ]
  certificate_arn = dependency.acm.outputs.arn
}
