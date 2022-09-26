terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.3"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.29"
    }
  }

  required_version = "~> 1.1"
}
