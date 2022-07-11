provider "github" {
  owner = "nikitabarskov"
  token = var.github_oauth_token
}

provider "tfe" {
  token = var.tfe_token
}
