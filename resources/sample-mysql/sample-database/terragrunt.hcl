dependency "cluster" {
  config_path = "../cluster"
}

terraform {
  source = "git::ssh://git@github.com/UpperGit/terraform-gcp.git//sql-db/database"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  database_instance_name = dependency.cluster.outputs.database_instance_name
  database_name          = "sample-database"

}

