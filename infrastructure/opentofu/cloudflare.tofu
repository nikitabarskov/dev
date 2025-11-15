data "cloudflare_user" "me" {}

data "cloudflare_api_token_permission_groups_list" "user" {
  scope = urlencode("com.cloudflare.api.user")
}

data "cloudflare_api_token_permission_groups_list" "account" {
  scope = urlencode("com.cloudflare.api.account")
}

data "cloudflare_api_token_permission_groups_list" "zone" {
  scope = urlencode("com.cloudflare.api.account.zone")
}

locals {
  cloudflare_account_id = "a71133601c96b473ef65e3c9ea99d689"
  cloudflare_api_token_permissions = {
    user = {
      for permission_group in data.cloudflare_api_token_permission_groups_list.user.result :
      permission_group.name => permission_group
    }
    account = {
      for permission_group in data.cloudflare_api_token_permission_groups_list.account.result :
      permission_group.name => permission_group
    }
    zone = {
      for permission_group in data.cloudflare_api_token_permission_groups_list.zone.result :
      permission_group.name => permission_group
    }
  }
}

import {
  to = cloudflare_api_token.spacelift
  id = "35725246b9f223c3e640cea30c27b96d"
}

resource "cloudflare_api_token" "spacelift" {
  name = "spacelift-nikitabarskov"
  policies = [
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_api_token_permissions.user["API Tokens Read"].id },
        { id = local.cloudflare_api_token_permissions.user["API Tokens Write"].id },
        { id = local.cloudflare_api_token_permissions.user["User Details Read"].id },
      ]
      resources = {
        "com.cloudflare.api.user.${data.cloudflare_user.me.id}" = "*"
      }
    },
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_api_token_permissions.account["Account API Tokens Read"].id },
        { id = local.cloudflare_api_token_permissions.account["Account API Tokens Write"].id },
      ]
      resources = {
        "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
      }
    }
  ]
  status = "active"
}
