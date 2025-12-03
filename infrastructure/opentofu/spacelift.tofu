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
      environment_variables = {
        "CLOUDFLARE_API_TOKEN" = {
          value = cloudflare_api_token.barskov_dev.value
        }
      }
    }
  }
}

moved {
  from = spacelift_stack.stacks
  to   = spacelift_stack.legacy_stacks
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

moved {
  from = spacelift_stack.main["barskov.dev"]
  to   = spacelift_stack.main["barskov-dev"]
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

resource "spacelift_environment_variable" "main" {
  for_each = {
    for item in flatten([
      for stack_name, stack_config in merge(local.spacelift_stacks) : [
        for name, config in try(stack_config.environment_variables, {}) : [{
          stack_name = stack_name
          name       = name
          value      = try(config.value, "")
          write_only = try(config.write_only, true)
        }]
      ]
    ]) : "${item.stack_name}###${item.name}" => item
  }

  stack_id   = spacelift_stack.main[each.value.stack_name].name
  name       = each.value.name
  value      = each.value.value
  write_only = each.value.write_only
}
