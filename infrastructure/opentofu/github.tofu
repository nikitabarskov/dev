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
    collaborators          = []
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
    "python-grpc-testing-demo" = {
      description = "A simple demo for `grpc-testing` package"
      visibility  = "public"
      topics = [
        "grpc",
        "python",
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
    "spr-ctl" = {
      collaborators = [
        {
          username   = "artemnorin"
          permission = "push"
        },
        {
          username   = "art4noir"
          permission = "push"
        },
      ]
    }
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

resource "github_branch_default" "main" {
  for_each = {
    for name, config in local.github_repositories : name => merge(local.github_repository_default, config)
  }
  repository = github_repository.main[each.key].name
  branch     = "main"
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

resource "github_repository_collaborators" "main" {
  for_each = {
    for name, config in local.github_repositories : name => merge(local.github_repository_default, config)
  }

  repository = github_repository.main[each.key].name

  dynamic "user" {
    for_each = each.value.collaborators
    content {
      username   = user.value.username
      permission = user.value.permission
    }
  }
}
