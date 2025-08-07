include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/acm"
}

dependency "zone" {
  config_path = "../../domain/zone"
  mock_outputs = {
    zone_id   = "GOTCHAI"
    zone_name = "gotchai-ai.com"
  }
}

inputs = {
  domain_name       = dependency.zone.outputs.zone_name
  zone_id           = dependency.zone.outputs.zone_id
  alternative_names = ["*.gotchai-ai.com"]
}
