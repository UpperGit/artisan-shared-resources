dependency "root_zone" {
  config_path  = "../root-zone"
  skip_outputs = true
}

locals {
  dns_vars = read_terragrunt_config(find_in_parent_folders("dns.hcl"))

  prefix   = local.dns_vars.locals.prefix
  name     = local.dns_vars.locals.name
  dns_zone = local.dns_vars.locals.dns_zone
}

terraform {
  source = "git::ssh://git@github.com/UpperGit/terraform-gcp.git//dns/records"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  prefix   = local.dns_vars.locals.prefix
  name     = local.dns_vars.locals.name
  dns_zone = local.dns_vars.locals.dns_zone

  records = [

    {
      subdomain = "sample-subdomain"
      type = "TXT"
      ttl  = 60
      record_set = [
        "\"My sample record\"",
      ]
    },

  ]

}
