locals {
  project_vars     = read_terragrunt_config(find_in_parent_folders("project.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))



  account_name  = local.account_vars.locals.account_name
  aws_region    = local.region_vars.locals.aws_region
  account_stage = local.account_vars.locals.account_stage
  env           = local.environment_vars.locals.environment
  tenant        = local.environment_vars.locals.tenant
  project_name  = local.project_vars.locals.project_name
  project_alt   = local.project_vars.locals.project_alt
}


generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  region = "${local.gcp_region}"
  project = ["${local.gcp_project_id}"]
}
EOF
}
