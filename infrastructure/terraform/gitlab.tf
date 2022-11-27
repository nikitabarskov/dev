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
  for_each = local.projects
  name     = each.value
}
