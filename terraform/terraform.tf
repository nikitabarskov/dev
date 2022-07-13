resource "tfe_organization" "nikita_barskov" {
  name  = "nikita-barskov"
  email = "nbarskov@gmail.com"
}

resource "tfe_oauth_client" "github" {
  name             = "terraform-github-oauth-token"
  organization     = "nikita-barskov"
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_oauth_token
  service_provider = "github"
}

resource "tfe_workspace" "dev" {
  name              = "dev"
  organization      = tfe_organization.nikita_barskov.name
  working_directory = "/terraform"
  queue_all_runs    = false
  vcs_repo {
    identifier         = github_repository.dev.full_name
    oauth_token_id     = tfe_oauth_client.github.oauth_token_id
    ingress_submodules = false
  }
  terraform_version = "~> 1.1"
}
