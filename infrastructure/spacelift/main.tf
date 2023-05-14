
resource "spacelift_stack" "spacelift_manager" {
  administrative    = true
  autodeploy        = false
  branch            = "main"
  name              = "Spacelift Manager"
  github_enterprise {
    namespace = "nikitabarskov"
  }
  project_root      = "/infrastructure/spacelift"
  repository        = "dev"
  terraform_version = "1.3.6"
  enable_local_preview = true
}

resource "spacelift_stack" "dev" {
  administrative    = true
  autodeploy        = false
  branch            = "main"
  name              = "dev"
  github_enterprise {
    namespace = "nikitabarskov"
  }
  project_root      = "/infrastructure/terraform"
  repository        = "dev"
  terraform_version = "1.3.6"
  enable_local_preview = true
}

resource "spacelift_environment_variable" "tf_var_github_oauth_token" {
  stack_id   = spacelift_stack.dev.id
  name       = "TF_VAR_github_oauth_token"
  value      = var.github_oauth_token
  write_only = true
}

resource "spacelift_environment_variable" "tf_var_vercel_api_token" {
  stack_id   = spacelift_stack.dev.id
  name       = "TF_VAR_vercel_api_token"
  value      = var.vercel_api_token
  write_only = true
}

resource "spacelift_environment_variable" "tf_var_gitlab_oauth_token" {
  stack_id   = spacelift_stack.dev.id
  name       = "TF_VAR_gitlab_oauth_token"
  value      = var.gitlab_oauth_token
  write_only = true
}

resource "spacelift_environment_variable" "tf_var_tfe_token" {
  stack_id   = spacelift_stack.dev.id
  name       = "TF_VAR_tfe_token"
  value      = var.tfe_token
  write_only = true
}
