locals {
  global_vars = read_terragrunt_config(find_in_parent_folders("global.hcl"))

  environment_id = get_env("ENVIRONMENT_ID", "unknown")

  credentials = local.global_vars.locals
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  version     = "~> 3.47.0"
  project     = "${local.credentials.project_id}"
  region      = "${local.credentials.region}"
}

provider "google-beta" {
  version     = "~> 3.47.0"
  project     = "${local.credentials.project_id}"
  region      = "${local.credentials.region}"
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${local.credentials.state_bucket}"
    key            = "${path_relative_to_include()}/${local.environment_id}/terraform.tfstate"
    region         = "${local.credentials.state_bucket_region}"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = local.global_vars.locals