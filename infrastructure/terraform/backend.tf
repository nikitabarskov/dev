terraform {
  backend "remote" {
    organization = "nikita-barskov"

    workspaces {
      name = "dev"
    }
  }
}
