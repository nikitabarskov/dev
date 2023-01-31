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

  security_and_analysis {
    advanced_security {
      status = "enabled"
    }
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }

  vulnerability_alerts = true

}

locals {
  github_repositories = {
    "data-engineer-challenge" = {
      archived   = true
      visibility = "private"
    },
    "data-engineer-assignment-kaggle-january-2023" = {
      archived   = true
      visibility = "private"
    }
  }
}

resource "github_repository" "private" {
  for_each = local.github_repositories
  name     = each.key

  visibility = each.value.visibility

  archived = each.value.archived

  lifecycle {
    ignore_changes = [
      security_and_analysis,
      vulnerability_alerts,
    ]
  }
}
