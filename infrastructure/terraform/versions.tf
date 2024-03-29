terraform {
  required_version = ">=1.6.0, <2.0.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 16.0"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "~> 1.0"
    }
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 1.1"
    }
  }
}
