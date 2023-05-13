terraform {
  required_version = ">= 1.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.9"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 15.8"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.11"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.39"
    }
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 1.1"
    }
  }
}
