include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../../modules/route53/records"
}

dependency "elb" {
  config_path = "../elb"
  mock_outputs = {
    dns_name = "gothcai-ai.com"
    zone_id  = "GOTCHAI"
  }
}

dependency "zone" {
  config_path = "${get_parent_terragrunt_dir()}/../../global/domain/zone"
  mock_outputs = {
    zone_name = "gotchai-ai.com"
  }
}

inputs = {
  zone_name = dependency.zone.outputs.zone_name
  records = [
    {
      name = "prod-api"
      type = "A"
      alias = {
        name    = dependency.elb.outputs.dns_name
        zone_id = dependency.elb.outputs.zone_id
      }
    },
  ]
}
