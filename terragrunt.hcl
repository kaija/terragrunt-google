locals {
  project_vars     = read_terragrunt_config(find_in_parent_folders("project.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  project_name     = local.project_vars.locals.project_name
  gcp_region       = local.region_vars.locals.gcp_region
  environment      = local.environment_vars.locals.environment
  gcp_project_id   = local.environment_vars.locals.project_id
}


generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  project = "${local.gcp_project_id}"
  region = "${local.gcp_region}"
}

provider "google-beta" {
  project = "${local.gcp_project_id}"
  region = "${local.gcp_region}"
}

EOF
}

remote_state {
  backend = "gcs"
  config = {
    project = "${local.gcp_project_id}"
    location = "us"
    bucket  = "${local.project_name}-terraform-${local.environment}"
    prefix  = "${path_relative_to_include()}/terraform.tfstate"
  }
}

inputs = merge(
  local.project_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
)

