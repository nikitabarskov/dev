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
      name     = "data-engineer-challenge"
      archived = true
    },
  }
}

resource "github_repository" "private" {
  for_each = local.github_repositories
  name     = each.value.name

  archived = each.value.archived

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
