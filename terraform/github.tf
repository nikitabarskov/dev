resource "github_repository" "dev" {
  name                   = "dev"
  visibility             = "public"
  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_squash_merge     = true
  delete_branch_on_merge = true
  topics = [
    "infrastructure",
    "terraform",
    "github",
  ]
}
