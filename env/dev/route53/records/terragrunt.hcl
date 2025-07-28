include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/route53/records"
}

dependency "alb" {
  config_path = "../../elb/alb"
  mock_outputs = {
    dns_name = "gothcai-ai.com"
    zone_id  = "GOTCHAI"
  }
}

dependency "zone" {
  config_path = "../zone"
  mock_outputs = {
    zone_name = "gotchai-ai.com"
  }
}

inputs = {
  zone_name = dependency.zone.outputs.zone_name
  records = [
    {
      name = "dev-api"
      type = "A"
      alias = {
        name    = dependency.alb.outputs.dns_name
        zone_id = dependency.alb.outputs.zone_id
      }
    }
  ]
}
