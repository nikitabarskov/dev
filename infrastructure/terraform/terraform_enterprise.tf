locals {
  tfe = {
    organisation_name = "nikita-barskov"
  }
}

resource "tfe_organization" "main" {
  name  = local.tfe.organisation_name
  email = "nbarskov@gmail.com"
}
