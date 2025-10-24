locals {
  github_repository_default = {
    archived               = false
    description            = ""
    homepage_url           = ""
    has_issues             = false
    has_discussions        = false
    has_projects           = false
    has_wiki               = false
    allow_merge_commit     = false
    allow_squash_merge     = false
    allow_rebase_merge     = true
    allow_auto_merge       = true
    delete_branch_on_merge = true
    topics                 = []
    required_status_checks = []
    visibility             = "private"
  }
  github_repositories = {
    "cv" = {
      description = "Sources for my resume"
      visibility  = "public"
      topics = [
        "cv",
        "curriculum-vitae",
        "resume",
      ]
    }
    "dev" = {
      homepage_url = "https://dev-tau-seven.vercel.app/"
      visibility   = "public"
      topics = [
        "github",
        "infrastructure",
        "terraform",
      ]
    }
    "experience" = {
      homepage_url = "https://experience-smoky.vercel.app"
      visibility   = "public"
      topics = [
        "knowledge",
        "learning",
        "notes",
        "wiki",
        "nextra",
      ]
      required_status_checks = [
        "Vercel",
      ]
    }
    "dotfiles" = {
      description = "My dev machine configuration via ansible."
      visibility  = "public"
      topics = [
        "dotfiles",
        "ansible",
        "automation",
        "dotfiles-macos",
        "dotfiles-ubuntu",
      ]
    }
    "uv-demo" = {
      description = "A simple demo repository for UV"
      visibility  = "public"
    }
    "python-grpc-testing-demo" = {
      description = "A simple demo for `grpc-testing` package"
      visibility  = "public"
      topics = [
        "grpc",
        "python",
      ]
    }
    "dbt-data-contracts-presentation" = {
      description = "Presentation for DBT Data Contracts for dbt MeetUp Oslo 2024-03-21"
      visibility  = "public"
      topics = [
        "dbt",
        "data-contracts",
        "dbt-meetup",
      ]
    }
    "supply-chain-security-demo" = {
      description = "A simple demo for supply chain"
      visibility  = "public"
      topics = [
        "supply-chain",
        "demo",
        "security",
      ]
    }
    "prompts" = {
      description = "Prompts I am using with Zed AI assistant"
      visibility  = "public"
      topics = [
        "zed",
        "prompt-engineering",
        "llms",
      ]
    }
    "stars-keeper" = {
      description = "I use it to keep track of my starred repositories and to categorize them"
      visibility  = "public"
      topics = [
        "stars",
        "github",
      ]
    }
    "recipes" = {
      description = "A collection of usefule recipes for Compose"
      visibility  = "public"
      topics = [
        "docker",
        "compose",
        "recipes",
      ]
    }
    "sandbox-volur" = {}
    "barskov.dev"   = {}
  }
}

moved {
  from = github_repository.public["cv"]
  to   = github_repository.main["cv"]
}

moved {
  from = github_repository.public["dev"]
  to   = github_repository.main["dev"]
}

moved {
  from = github_repository.public["experience"]
  to   = github_repository.main["experience"]
}

moved {
  from = github_repository.public["dotfiles"]
  to   = github_repository.main["dotfiles"]
}

moved {
  from = github_repository.public["uv-demo"]
  to   = github_repository.main["uv-demo"]
}

moved {
  from = github_repository.public["python-grpc-testing-demo"]
  to   = github_repository.main["python-grpc-testing-demo"]
}

moved {
  from = github_repository.public["dbt-data-contracts-presentation"]
  to   = github_repository.main["dbt-data-contracts-presentation"]
}

moved {
  from = github_repository.public["supply-chain-security-demo"]
  to   = github_repository.main["supply-chain-security-demo"]
}

moved {
  from = github_repository.public["prompts"]
  to   = github_repository.main["prompts"]
}

moved {
  from = github_repository.public["stars-keeper"]
  to   = github_repository.main["stars-keeper"]
}

moved {
  from = github_repository.public["recipes"]
  to   = github_repository.main["recipes"]
}

moved {
  from = github_repository.private["sandbox-volur"]
  to   = github_repository.main["sandbox-volur"]
}

moved {
  from = github_repository.private["barskov.dev"]
  to   = github_repository.main["barskov.dev"]
}

removed {
  from = github_repository.public
  lifecycle {
    destroy = false
  }
}

removed {
  from = github_repository.private
  lifecycle {
    destroy = false
  }
}

resource "github_repository" "main" {
  for_each = {
    for name, config in local.github_repositories : name => merge(local.github_repository_default, config)
  }

  name         = each.key
  description  = each.value.description
  homepage_url = each.value.homepage_url

  visibility = each.value.visibility

  auto_init = true

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

  archive_on_destroy = true
}

removed {
  from = github_branch.main

  lifecycle {
    destroy = false
  }
}

resource "github_branch_default" "main" {
  for_each = {
    for name, config in local.github_repositories : name => merge(local.github_repository_default, config)
  }
  repository = github_repository.main[each.key].name
  branch     = "main"
}

moved {
  from = github_branch_protection.public["cv"]
  to   = github_branch_protection.main["cv"]
}

moved {
  from = github_branch_protection.public["dev"]
  to   = github_branch_protection.main["dev"]
}

moved {
  from = github_branch_protection.public["experience"]
  to   = github_branch_protection.main["experience"]
}

moved {
  from = github_branch_protection.public["dotfiles"]
  to   = github_branch_protection.main["dotfiles"]
}

moved {
  from = github_branch_protection.public["uv-demo"]
  to   = github_branch_protection.main["uv-demo"]
}

moved {
  from = github_branch_protection.public["python-grpc-testing-demo"]
  to   = github_branch_protection.main["python-grpc-testing-demo"]
}

moved {
  from = github_branch_protection.public["dbt-data-contracts-presentation"]
  to   = github_branch_protection.main["dbt-data-contracts-presentation"]
}

moved {
  from = github_branch_protection.public["supply-chain-security-demo"]
  to   = github_branch_protection.main["supply-chain-security-demo"]
}

moved {
  from = github_branch_protection.public["prompts"]
  to   = github_branch_protection.main["prompts"]
}

moved {
  from = github_branch_protection.public["stars-keeper"]
  to   = github_branch_protection.main["stars-keeper"]
}

moved {
  from = github_branch_protection.public["recipes"]
  to   = github_branch_protection.main["recipes"]
}

resource "github_branch_protection" "main" {
  for_each = {
    for name, config in local.github_repositories : name => merge(local.github_repository_default, config)
  }

  repository_id = github_repository.main[each.key].node_id

  pattern                = "main"
  require_signed_commits = true

  required_status_checks {
    strict   = false
    contexts = each.value.required_status_checks
  }
}
