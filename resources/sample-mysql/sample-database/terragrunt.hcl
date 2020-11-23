dependency "cluster" {
  config_path = "../cluster"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  environment_id = local.environment_vars.locals.environment_id
}

terraform {
  source = "git::ssh://git@github.com/UpperGit/terraform-gcp.git//sql-db/database"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  dabatase_instance_name = dependency.cluster.outputs.database_instance_name
  database_name          = "sample-database"

}

