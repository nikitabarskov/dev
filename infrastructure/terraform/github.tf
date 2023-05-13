locals {
  github_repository_default = {
    description            = ""
    homepage_url           = ""
    has_issues             = false
    has_discussions        = false
    has_projects           = false
    has_wiki               = false
    allow_merge_commit     = false
    allow_squash_merge     = true
    allow_rebase_merge     = true
    allow_auto_merge       = true
    delete_branch_on_merge = true
    topics                 = []
  }
  public_github_repositories = {
    "dev" = {
      homepage_url = "https://dev-tau-seven.vercel.app/"
      topics = [
        "github",
        "infrastructure",
        "terraform",
      ]
    }
  }
  private_github_repositories = {
    "data-engineer-challenge" = {
      archived = true
    },
    "data-engineer-assignment-kaggle-january-2023" = {
      archived = true
    }
  }
}

resource "github_repository" "public" {
  for_each = {
    for name, config in local.public_github_repositories : name => merge(local.github_repository_default, config)
  }

  name         = each.key
  description  = each.value.description
  homepage_url = each.value.homepage_url

  has_issues   = each.value.has_issues
  has_projects = each.value.has_projects
  has_wiki     = each.value.has_wiki

  allow_auto_merge   = each.value.allow_auto_merge
  allow_merge_commit = each.value.allow_merge_commit
  allow_squash_merge = each.value.allow_squash_merge
  allow_rebase_merge = each.value.allow_rebase_merge

  delete_branch_on_merge = each.value.delete_branch_on_merge

  topics = each.value.topics

  lifecycle {
    ignore_changes = [
        security_and_analysis,
        vulnerability_alerts,
    ]
  }
}

resource "github_repository" "private" {
  for_each = local.private_github_repositories
  name     = each.key

  visibility = "private"

  archived = each.value.archived

  lifecycle {
    ignore_changes = [
      security_and_analysis,
      vulnerability_alerts,
    ]
  }
}
