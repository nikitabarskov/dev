provider "github" {
  owner = "nikitabarskov"
  token = var.github_oauth_token
}
provider "gitlab" {
  token = var.gitlab_oauth_token
}
provider "vercel" {
  api_token = var.vercel_api_token
}
provider "tfe" {
  token = var.tfe_token
}
