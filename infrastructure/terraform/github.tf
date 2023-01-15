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
      name       = "data-engineer-challenge"
      archived   = true
      visibility = "public"
      security_and_analysis = {
        advanced_security = {
          status = "disabled"
        }
        secret_scanning = {
          status = "disabled"
        }
        secret_scanning_push_protection = {
          status = "disabled"
        }
      }
      vulnerability_alerts = false
    },
    "data-engineer-assignment-kaggle-january-2023" = {
      archived   = false
      visibility = "private"
      security_and_analysis = {
        advanced_security = {
          status = "disabled"
        }
        secret_scanning = {
          status = "disabled"
        }
        secret_scanning_push_protection = {
          status = "disabled"
        }
      }
      vulnerability_alerts = false
    }
  }
}

resource "github_repository" "private" {
  for_each = local.github_repositories
  name     = each.key

  visibility = each.value.visibility

  archived = each.value.archived

  security_and_analysis {
    advanced_security {
      status = each.value.security_and_analysis.advanced_security.status
    }
    secret_scanning {
      status = each.value.security_and_analysis.secret_scanning.status
    }
    secret_scanning_push_protection {
      status = each.value.security_and_analysis.secret_scanning_push_protection.status
    }
  }

  vulnerability_alerts = true

}
