provider "cloudflare" {}
provider "github" {
  owner = "nikitabarskov"
  token = var.github_oauth_token
}
provider "gitlab" {
  token = var.gitlab_oauth_token
}
provider "spacelift" {}
provider "random" {}
