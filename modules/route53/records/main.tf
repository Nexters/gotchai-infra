module "records" {
  source = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name
  records   = var.records
}
