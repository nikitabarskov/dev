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

import {
  to = gitlab_branch_protection.main["dev"]
  id = "25612642:master"
}

import {
  to = gitlab_branch_protection.main["infra"]
  id = "25780290:master"
}

import {
  to = gitlab_branch_protection.main["research"]
  id = "20944318:master"
}

resource "gitlab_branch_protection" "main" {
  for_each               = local.projects
  branch                 = "master"
  project                = gitlab_project.projects[each.value].id
  push_access_level      = "maintainer"
  merge_access_level     = "maintainer"
  unprotect_access_level = "maintainer"
}
