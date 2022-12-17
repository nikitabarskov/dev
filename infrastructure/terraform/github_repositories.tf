resource "github_repository" "dev" {
  name         = "dev"
  homepage_url = "https://dev-tau-seven.vercel.app/"

  allow_auto_merge   = true
  allow_merge_commit = false
  allow_rebase_merge = true

  delete_branch_on_merge = true

  topics = [
    "github",
    "infrastructure",
    "terraform",
  ]

  vulnerability_alerts = true

}

locals {
  github_repositories = toset([
    "data-engineer-challenge",
  ])
}

resource "github_repository" "private" {
  for_each = local.github_repositories
  name     = each.value

  vulnerability_alerts = true
}
