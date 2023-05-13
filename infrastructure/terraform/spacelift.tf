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
  enable_local_preview = true
}
