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
  stacks = {
    "barskov.dev" = {
      repository   = "barskov.dev"
      autodeploy   = true
      description  = "Stack to manage my personal infrastructure"
      project_root = "/infrastructure/opentofu"
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
}

resource "spacelift_stack" "main" {
  for_each = local.stacks

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
