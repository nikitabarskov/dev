terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 1.0"
    }
  }
}

resource "spacelift_stack" "dev" {
  autodeploy        = false
  branch            = "main"
  name              = "dev"
  github_enterprise {
    namespace = "nikitabarskov"
  }
  project_root      = "/infrastructure/terraform"
  repository        = "dev"
  terraform_version = "1.3.6"
}

resource "spacelift_environment_variable" "tf_var_github_oauth_token" {
  stack_id   = spacelift_stack.dev.id
  name       = "TF_VAR_github_oauth_token"
  value      = var.TF_VAR_github_oauth_token
  write_only = true
}
resource "spacelift_environment_variable" "tf_var_vercel_api_token" {
  stack_id   = spacelift_stack.dev.id
  name       = "TF_VAR_vercel_api_token"
  value      = var.TF_VAR_vercel_api_token
  write_only = true
}
resource "spacelift_environment_variable" "tf_var_gitlab_oauth_token" {
  stack_id   = spacelift_stack.dev.id
  name       = "TF_VAR_gitlab_oauth_token"
  value      = var.TF_VAR_gitlab_oauth_token
  write_only = true
}
resource "spacelift_environment_variable" "tf_var_tfe_token" {
  stack_id   = spacelift_stack.dev.id
  name       = "TF_VAR_tfe_token"
  value      = var.TF_VAR_tfe_token
  write_only = true
}

variable "github_oauth_token" {
  type      = string
  sensitive = true
}

variable "gitlab_oauth_token" {
  type      = string
  sensitive = true
}

variable "vercel_api_token" {
  type      = string
  sensitive = true
}

variable "tfe_token" {
  type      = string
  sensitive = true
}
