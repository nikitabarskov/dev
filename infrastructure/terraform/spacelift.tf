locals {
  stacks = {
    "dev" = {
      repository     = "dev"
      administrative = true
      autodeploy     = true
      description    = "Stack to manage my personal infrastructure"
      project_root   = "/infrastructure/terraform"
    }
  }
}

resource "spacelift_stack" "stacks" {
  for_each = local.stacks

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
  project_root      = each.value.project_root
  terraform_version = ">=1.3.0 <2.0.0"
}
