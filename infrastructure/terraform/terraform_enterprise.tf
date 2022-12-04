resource "tfe_organization" "main" {
  name  = "nikita-barskov"
  email = "nbarskov@gmail.com"
}

resource "tfe_oauth_client" "github" {
  name             = "github"
  organization     = "nikita-barskov"
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_oauth_token
  service_provider = "github"
}

resource "tfe_workspace" "dev" {
  name              = "dev"
  organization      = tfe_organization.main.name
  working_directory = "/infrastructure/terraform"
  queue_all_runs    = false
  vcs_repo {
    identifier         = github_repository.dev.full_name
    oauth_token_id     = tfe_oauth_client.github.oauth_token_id
    ingress_submodules = false
  }
}

locals {
  tfe_variables = {
    github_oauth_token = var.github_oauth_token
    gitlab_oauth_token = var.gitlab_oauth_token
    vercel_api_token   = var.vercel_api_token
    tfe_token          = var.tfe_token
  }
}

resource "tfe_variable" "variables" {
  for_each     = local.tfe_variables
  key          = each.key
  value        = each.value
  category     = "terraform"
  sensitive    = true
  workspace_id = tfe_workspace.dev.id
}
