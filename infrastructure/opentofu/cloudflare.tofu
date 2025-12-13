locals {
  cloudflare_account_id = "a71133601c96b473ef65e3c9ea99d689"
}

data "cloudflare_account" "this" {
  account_id = local.cloudflare_account_id
}

data "cloudflare_account_api_token_permission_groups_list" "account" {
  account_id = data.cloudflare_account.this.id
  scope      = urlencode("com.cloudflare.api.account")
}

data "cloudflare_account_api_token_permission_groups_list" "r2" {
  account_id = local.cloudflare_account_id
  scope      = urlencode("com.cloudflare.edge.r2.bucket")
}

data "cloudflare_account_api_token_permission_groups_list" "zone" {
  account_id = data.cloudflare_account.this.id
  scope      = urlencode("com.cloudflare.api.account.zone")
}

locals {
  cloudflare_account_token_permission_groups = {
    account = {
      for permission_group in data.cloudflare_account_api_token_permission_groups_list.account.result :
      permission_group.name => permission_group
    }
    r2 = {
      for permission_group in data.cloudflare_account_api_token_permission_groups_list.r2.result :
      permission_group.name => permission_group
    }
    zone = {
      for permission_group in data.cloudflare_account_api_token_permission_groups_list.zone.result :
      permission_group.name => permission_group
    }
  }
}

import {
  to = cloudflare_account_token.spacelift
  id = "${data.cloudflare_account.this.account_id}/e97d68a6bf0566acf1e47999287d1cc9"
}

resource "cloudflare_account_token" "spacelift" {
  account_id = data.cloudflare_account.this.account_id
  name       = "spacelift-dev"
  policies = [
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_account_token_permission_groups.account["Account API Tokens Read"].id },
        { id = local.cloudflare_account_token_permission_groups.account["Account API Tokens Write"].id },
        { id = local.cloudflare_account_token_permission_groups.account["Account Settings Read"].id },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
      })
    },
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_account_token_permission_groups.account["Account API Tokens Read"].id },
        { id = local.cloudflare_account_token_permission_groups.account["Account API Tokens Write"].id },
        { id = local.cloudflare_account_token_permission_groups.account["Account Settings Read"].id },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
      })
    },
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_account_token_permission_groups.zone["Zone Write"].id },
        { id = local.cloudflare_account_token_permission_groups.zone["Zone Settings Read"].id },
        { id = local.cloudflare_account_token_permission_groups.zone["Zone Settings Write"].id },
        { id = local.cloudflare_account_token_permission_groups.zone["DNS Read"].id },
        { id = local.cloudflare_account_token_permission_groups.zone["DNS Write"].id },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
      })
    },
  ]
  status = "active"
}

resource "cloudflare_account_token" "barskov_dev" {
  account_id = data.cloudflare_account.this.account_id
  name       = "spacelift-barskov-dev"
  policies = [
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_account_token_permission_groups.zone["Zone Write"].id },
        { id = local.cloudflare_account_token_permission_groups.zone["Zone Settings Read"].id },
        { id = local.cloudflare_account_token_permission_groups.zone["Zone Settings Write"].id },
        { id = local.cloudflare_account_token_permission_groups.zone["DNS Read"].id },
        { id = local.cloudflare_account_token_permission_groups.zone["DNS Write"].id },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
      })
    },
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_account_token_permission_groups.account["Workers R2 Storage Read"].id },
        { id = local.cloudflare_account_token_permission_groups.account["Workers R2 Storage Write"].id },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
      })
    }
  ]
  status = "active"
}

resource "cloudflare_account_token" "github_actions_barskov_dev" {
  account_id = data.cloudflare_account.this.account_id
  name       = "github-actions-barskov-dev"
  policies = [{
    effect = "allow"
    permission_groups = [
      { id = local.cloudflare_account_token_permission_groups.r2["Workers R2 Storage Bucket Item Read"].id },
      { id = local.cloudflare_account_token_permission_groups.r2["Workers R2 Storage Bucket Item Write"].id },
    ]
    resources = jsonencode({
      "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
    })
  }]
  status = "active"
}
