resource "github_repository" "dev" {
  name                   = "dev"
  visibility             = "public" #tfsec:ignore:github-repositories-private
  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_squash_merge     = true
  delete_branch_on_merge = true
  vulnerability_alerts   = true
  topics = [
    "infrastructure",
    "terraform",
    "github",
  ]
}

resource "github_branch_default" "dev_default" {
  repository = github_repository.dev.name
  branch     = "main"
}

resource "github_branch_protection" "dev_main" {
  repository_id                   = github_repository.dev.node_id
  pattern                         = "main"
  require_signed_commits          = true
  required_linear_history         = true
  require_conversation_resolution = true
  enforce_admins                  = true
  required_status_checks {
    strict = true
    contexts = [
      "build",
    ]
  }
  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 0
    pull_request_bypassers = [
      data.github_user.nikita_barskov.node_id,
    ]
  }
}

resource "github_repository" "degree" {
  name        = "degree"
  description = "Materials, reports, bureaucratic documents relating to my scientific work (master's thesis)."
  visibility  = "public" #tfsec:ignore:github-repositories-private
  archived    = true
}

resource "github_repository" "dotfiles" {
  name                   = "dotfiles"
  description            = "My dev machine configuration via ansible."
  visibility             = "public" #tfsec:ignore:github-repositories-private
  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_squash_merge     = true
  delete_branch_on_merge = true
  vulnerability_alerts   = true
  topics = [
    "ansible",
    "automation",
    "dotfiles",
    "dotfiles-ubuntu",
    "dotfiles-macos",
  ]
}

resource "github_repository" "cv" {
  name                   = "cv"
  description            = "Curriculum Vitae."
  visibility             = "public" #tfsec:ignore:github-repositories-private
  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_squash_merge     = true
  delete_branch_on_merge = true
  vulnerability_alerts   = true
  topics = [
    "cv",
    "curriculum-vitae",
  ]
}

resource "github_repository" "sandbox_coopnorge" {
  name                 = "sandbox-coopnorge"
  visibility           = "private"
  vulnerability_alerts = false #tfsec:ignore:github-repositories-enable_vulnerability_alerts
}

data "github_user" "nikita_barskov" {
  username = "nikitabarskov"
}
