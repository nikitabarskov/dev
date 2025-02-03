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
    visibility             = "public"
  }
  public_github_repositories = {
    "cv" = {
      description = "Sources for my resume"
      topics = [
        "cv",
        "curriculum-vitae",
        "resume",
      ]
    }
    "dev" = {
      homepage_url = "https://dev-tau-seven.vercel.app/"
      topics = [
        "github",
        "infrastructure",
        "terraform",
      ]
    }
    "experience" = {
      homepage_url = "https://experience-smoky.vercel.app"
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
    }
    "python-grpc-testing-demo" = {
      description = "A simple demo for `grpc-testing` package"
      topics = [
        "grpc",
        "python",
      ]
    }
    "dbt-data-contracts-presentation" = {
      description = "Presentation for DBT Data Contracts for dbt MeetUp Oslo 2024-03-21"
      topics = [
        "dbt",
        "data-contracts",
        "dbt-meetup",
      ]
    }
    "supply-chain-security-demo" = {
      description = "A simple demo for supply chain"
      topics = [
        "supply-chain",
        "demo",
        "security",
      ]
    }
    "prompts" = {
      description = "Prompts I am using with Zed AI assistant"
      topics = [
        "zed",
        "prompt-engineering",
        "llms",
      ]
    }
  }
  private_github_repositories = {
    "sandbox-volur" = {}
    "barskov.dev"   = {}
  }
}

resource "github_repository" "public" {
  for_each = {
    for name, config in local.public_github_repositories : name => merge(local.github_repository_default, config)
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

resource "github_branch" "main" {
  for_each = {
    for name, config in local.public_github_repositories : name => merge(local.github_repository_default, config)
  }
  repository = github_repository.public[each.key].name
  branch     = "main"
}

resource "github_branch_default" "main" {
  for_each = {
    for name, config in local.public_github_repositories : name => merge(local.github_repository_default, config)
  }
  repository = github_repository.public[each.key].name
  branch     = github_branch.main[each.key].branch
}

resource "github_branch_protection" "public" {
  for_each = {
    for name, config in local.public_github_repositories : name => merge(local.github_repository_default, config)
  }

  repository_id = github_repository.public[each.key].node_id

  pattern                = "main"
  require_signed_commits = true

  required_status_checks {
    strict   = false
    contexts = each.value.required_status_checks
  }
}

resource "github_repository" "private" {
  for_each = {
    for name, config in local.private_github_repositories : name => merge(local.github_repository_default, config)
  }

  name = each.key

  visibility = "private"

  archived = each.value.archived

  lifecycle {
    ignore_changes = [
      security_and_analysis,
      vulnerability_alerts,
    ]
  }
}
