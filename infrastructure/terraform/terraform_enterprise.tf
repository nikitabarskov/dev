locals {
  tfe = {
    organisation_name = "nikita-barskov"
  }
}

resource "tfe_organization" "main" {
  name  = local.tfe.organisation_name
  email = "nbarskov@gmail.com"
}

resource "tfe_oauth_client" "github" {
  name             = "github"
  organization     = local.tfe.organisation_name
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
  force_delete      = true
  vcs_repo {
    identifier         = github_repository.public["dev"].full_name
    oauth_token_id     = tfe_oauth_client.github.oauth_token_id
    ingress_submodules = false
  }
}
