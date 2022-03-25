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

resource "github_repository" "degree" {
  name = "degree"
  description = "Materials, reports, bureaucratic documents relating to my scientific work (master's thesis)."
  visibility = "public"
  archived = true
}

resource "github_repository" "dotfiles" {
  name = "dotfiles"
  description = "My dev machine configuration via ansible."
  visibility = "public"
  topics = [
    "ansible",
    "automation",
    "dotfiles",
    "dotfiles-ubuntu",
    "dotfiles-macos",
  ]
}

resource "github_repository" "sandbox_coopnorge" {
  name = "sandbox-coopnorge"
  visibility = "private"
}