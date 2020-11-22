locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  environment_id = local.environment_vars.locals.environment_id

  prefix = local.environment_id

  name     = "sample-zone"
  dns_zone = "sample-zone.com"

}
