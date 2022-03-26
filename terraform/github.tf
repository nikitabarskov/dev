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
