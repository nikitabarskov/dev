resource "vercel_project" "dev" {
  name      = "dev"
  framework = "nextjs"

  git_repository = {
    repo              = github_repository.public["dev"].full_name
    type              = "github"
    production_branch = "main"
  }

  root_directory = "blog"
}
