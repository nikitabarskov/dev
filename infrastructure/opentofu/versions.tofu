terraform {
  required_version = ">=1.6.0, <2.0.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">=5.0.0,<6"
    }
    github = {
      source  = "integrations/github"
      version = ">=6.0.0,<6.8.0"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = ">=18.0.0,<19"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.0.0,<4"
    }
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = ">=1.0.0,<2"
    }
  }
}
