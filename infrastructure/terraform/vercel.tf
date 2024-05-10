resource "vercel_project" "dev" {
  name      = "dev"
  framework = "nextjs"

  install_command = "pnpm install --frozen-lockfile"
  build_command   = "pnpm build"

  git_repository = {
    repo              = github_repository.public["dev"].full_name
    type              = "github"
    production_branch = "main"
  }

  root_directory = "blog"
}

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

  install_command = "pnpm install --frozen-lockfile"
  build_command   = "pnpm build"

  git_repository = {
    repo              = github_repository.public[each.value.github_repository_name].full_name
    type              = "github"
    production_branch = "main"
  }
}
