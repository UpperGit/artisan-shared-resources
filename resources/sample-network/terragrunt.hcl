locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  environment_id = local.environment_vars.locals.environment_id
}

terraform {
  source = "git::ssh://git@github.com/UpperGit/terraform-gcp.git//networking"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  prefix = local.environment_id
  name = "sample-nw"

  mtu = 1500

  subnetworks = {
    public-ingress = {
      
      cidr = "10.100.0.0/22",
      region = "us-central1",

    }
  }

  service_networking_regions = [
    "us-central1",
  ]

  access_connectors = {
    "us-central1" = {

      cidr         = "10.8.0.0/28",
      min_throughput = 200,
      max_throughput = 300,

    }
  }

}