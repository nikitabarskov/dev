locals {
  groups = toset([
    "soawesometeam",
    "barskov-public",
    "barskov-internal",
  ])
}

resource "gitlab_group" "groups" {
  for_each = local.groups
  name     = each.value
  path     = each.value
}

locals {
  projects = toset([
    "dev",
    "infra",
    "research",
  ])
}

resource "gitlab_project" "projects" {
  for_each       = local.projects
  name           = each.value
  default_branch = "main"
}

resource "gitlab_branch_protection" "main" {
  for_each               = local.projects
  branch                 = "main"
  project                = gitlab_project.projects[each.value].id
  push_access_level      = "maintainer"
  merge_access_level     = "maintainer"
  unprotect_access_level = "maintainer"
}
