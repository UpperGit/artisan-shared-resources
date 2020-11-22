dependency "sample_nw" {
  config_path = "../../sample-network"
}

locals {
  dns_vars = read_terragrunt_config(find_in_parent_folders("dns.hcl"))

  prefix   = local.dns_vars.locals.prefix
  name     = local.dns_vars.locals.name
  dns_zone = local.dns_vars.locals.dns_zone
}

terraform {
  source = "git::ssh://git@github.com/UpperGit/terraform-gcp.git//dns"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  prefix   = local.prefix
  name     = local.name
  dns_zone = local.dns_zone

  private_network_ids = [
    dependency.sample_nw.outputs.private_network_id,
  ]

  is_private = true

}
