dependency "cluster" {
  config_path = "../../cluster"
}

terraform {
  source = "git::ssh://git@github.com/UpperGit/terraform-gcp.git//sql-db/iam"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  database_instance_name = dependency.cluster.outputs.database_instance_name

  common_name = "admin-tls"
  enable_tls  = true

  password_keeper = "kangaroo"
  username        = "admin"
  enable_password = true

}

