dependency "sample_nw" {
	config_path = "../sample-network"
}

locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  environment_id = local.environment_vars.locals.environment_id
}

terraform {
  source = "git::ssh://git@github.com/UpperGit/terraform-gcp.git//sql-db"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  prefix = local.environment_id
  name = "sample-mysql"

  private_network_id = dependency.sample_nw.outputs.private_network_id

  database_version = "MYSQL_5_7"
  deletion_protection = false
  tier = "db-f1-micro"
  availability_type = "ZONAL"

  backup_enabled = false
  failover_instance_count = 0
  read_replica_count = 0

}

