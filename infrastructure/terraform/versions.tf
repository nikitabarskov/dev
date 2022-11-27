terraform {
  required_version = ">= 1.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.9"
    }
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "~> 3.20"
    }
  }
}
