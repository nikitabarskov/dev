locals {
  legacy_stacks = {
    "dev" = {
      repository     = "dev"
      administrative = true
      autodeploy     = true
      description    = "Stack to manage my personal infrastructure"
      project_root   = "/infrastructure/opentofu"
    }
  }
  spacelift_stacks = {
    "barskov-dev" = {
      repository   = "barskov.dev"
      autodeploy   = true
      description  = "Stack to manage infrastructure of my personal website"
      project_root = "/infrastructure/opentofu"
    }
  }
}

resource "spacelift_stack" "legacy_stacks" {
  for_each = local.legacy_stacks

  branch     = "main"
  name       = each.key
  repository = each.value.repository

  administrative       = each.value.administrative
  autodeploy           = each.value.autodeploy
  enable_local_preview = true
  description          = each.value.description
  github_enterprise {
    namespace = "nikitabarskov"
  }
  project_root            = each.value.project_root
  terraform_workflow_tool = "OPEN_TOFU"
  terraform_version       = ">=1.6.0 <2.0.0"
  runner_image            = "ghcr.io/nikitabarskov/spacelift-runner:latest"
}

resource "spacelift_stack" "main" {
  for_each = local.spacelift_stacks

  branch     = "main"
  name       = each.key
  repository = each.value.repository

  autodeploy           = each.value.autodeploy
  enable_local_preview = true
  description          = each.value.description
  github_enterprise {
    namespace = "nikitabarskov"
  }
  project_root            = each.value.project_root
  terraform_workflow_tool = "OPEN_TOFU"
  terraform_version       = ">=1.6.0 <2.0.0"
}

resource "spacelift_environment_variable" "dev_cloudflare_token" {
  stack_id   = spacelift_stack.legacy_stacks["dev"].name
  name       = "CLOUDFLARE_API_TOKEN"
  value      = cloudflare_api_token.spacelift.value
  write_only = true
}

resource "spacelift_environment_variable" "barskov_dev_cloudflare_token" {
  stack_id   = spacelift_stack.main["barskov-dev"].name
  name       = "CLOUDFLARE_API_TOKEN"
  value      = cloudflare_api_token.barskov_dev.value
  write_only = true
}
