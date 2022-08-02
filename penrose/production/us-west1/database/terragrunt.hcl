locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  project_vars     = read_terragrunt_config(find_in_parent_folders("project.hcl"))
  env              = local.environment_vars.locals.environment
  project_alias    = local.project_vars.locals.project_alias
  project_name     = local.project_vars.locals.project_name
}


terraform {
  source = "../../../..//modules/database"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  environment = local.env
}
