terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.22"
    }
  }

  required_version = "~> 1.1"
}