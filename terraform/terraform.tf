resource "tfe_organization" "nikita_barskov" {
  name  = "nikita-barskov"
  email = "nbarskov@protonmail.com"
}

resource "tfe_workspace" "dev" {
  name              = "dev"
  organization      = tfe_organization.nikita_barskov.name
  working_directory = "/terraform"
  queue_all_runs    = false
  terraform_version = "~> 1.1"
  vcs_repo {
    identifier         = github_repository.dev.full_name
    oauth_token_id     = var.github_oauth_token
    ingress_submodules = false
  }
}