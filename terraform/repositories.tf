resource "github_repository" "finn_no_crawler" {
  name       = "finn-no-crawler"
  visibility = "private"
  has_issues = true

  allow_merge_commit     = false
  allow_rebase_merge     = true
  allow_squash_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true
  auto_init              = true

  vulnerability_alerts = false
}

resource "github_branch_default" "finn_no_crawler" {
  repository = github_repository.finn_no_crawler.name
  branch     = "main"
}
