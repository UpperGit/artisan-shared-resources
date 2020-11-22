locals {
  global_vars = yamldecode(file(find_in_parent_folders("global.yaml")))

  environment_id = get_env("ENVIRONMENT_ID", "unknown")
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  version     = "~> 3.47.0"
  project     = "${local.global_vars.project_id}"
  region      = "${local.global_vars.region}"
}

provider "google-beta" {
  version     = "~> 3.47.0"
  project     = "${local.global_vars.project_id}"
  region      = "${local.global_vars.region}"
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${local.global_vars.state_bucket}"
    key            = "${path_relative_to_include()}/${local.environment_id}/terraform.tfstate"
    region         = "${local.global_vars.state_bucket_region}"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = local.global_vars