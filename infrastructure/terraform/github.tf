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
    "experience" = {
      topics = [
        "knowledge",
        "learning",
        "notes",
        "wiki",
        "nextra",
      ]
    }
    "dbt-meetup-2023-05-31" = {
      topics = [
        "dbt",
        "automation",
      ]
      description = "Presentation and code for Oslo DBT meet-up on 2023-05-31"
    }
    "dbt-model-versions-demo" = {
      description = "Code and presentation for dbt model versions demo"
      topics = [
        "dbt",
        "automation",
      ]
    }
    "dotfiles" = {
      description = "My dev machine configuration via ansible."
      topics = [
        "dotfiles",
        "ansible",
        "automation",
        "dotfiles-macos",
        "dotfiles-ubuntu",
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

resource "github_branch_protection" "public" {
  for_each = {
    for name, config in local.public_github_repositories : name => merge(local.github_repository_default, config)
  }

  repository_id = github_repository.public[each.key].node_id

  pattern                = "main"
  require_signed_commits = true
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
