locals {
  vercel_projects = {
    "experience" = {
      github_repository_name = "experience"
    }
  }
}

resource "vercel_project" "main" {
  for_each = local.vercel_projects

  name      = each.key
  framework = "nextjs"

  git_repository = {
    repo              = github_repository.public[each.value.github_repository_name].full_name
    type              = "github"
    production_branch = "main"
  }
}
