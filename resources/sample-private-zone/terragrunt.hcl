dependency "sample_nw" {
  config_path = "../sample-network"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  environment_id = local.environment_vars.locals.environment_id
}

terraform {
  source = "git::ssh://git@github.com/UpperGit/terraform-gcp.git//dns"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  prefix = local.environment_id

  name     = "sample-zone"
  dns_zone = "sample-zone.com"

  private_network_ids = [
    dependency.sample_nw.outputs.private_network_id,
  ]

  is_private = true

}
