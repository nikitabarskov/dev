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

data "cloudflare_account_api_token_permission_groups_list" "account" {
  account_id = local.cloudflare_account_id
  scope      = urlencode("com.cloudflare.api.account")
}

data "cloudflare_account_api_token_permission_groups_list" "r2" {
  account_id = local.cloudflare_account_id
  scope      = urlencode("com.cloudflare.edge.r2.bucket")
}

locals {
  cloudflare_account_id = "a71133601c96b473ef65e3c9ea99d689"
  cloudflare_api_token_permission_groups = {
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
  cloudflare_account_api_token_permission_groups = {
    account = {
      for permission_group in data.cloudflare_account_api_token_permission_groups_list.account.result :
      permission_group.name => permission_group
    }
    r2 = {
      for permission_group in data.cloudflare_account_api_token_permission_groups_list.r2.result :
      permission_group.name => permission_group
    }
  }
}

resource "cloudflare_api_token" "barskov_dev" {
  name = "spacelift-barskov-dev"
  policies = [
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_api_token_permission_groups.zone["Zone Write"].id },
        { id = local.cloudflare_api_token_permission_groups.zone["Zone Settings Read"].id },
        { id = local.cloudflare_api_token_permission_groups.zone["Zone Settings Write"].id },
        { id = local.cloudflare_api_token_permission_groups.zone["DNS Read"].id },
        { id = local.cloudflare_api_token_permission_groups.zone["DNS Write"].id },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.zone.*" = "*"
      })
    },
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_api_token_permission_groups.account["Workers R2 Storage Read"].id },
        { id = local.cloudflare_api_token_permission_groups.account["Workers R2 Storage Write"].id },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
      })
    }
  ]
}

resource "cloudflare_api_token" "github_actions_barskov_dev" {
  name = "github-actions-barskov-dev"
  policies = [{
    effect = "allow"
    permission_groups = [
      { id = local.cloudflare_account_api_token_permission_groups.r2["Workers R2 Storage Bucket Item Read"].id },
      { id = local.cloudflare_account_api_token_permission_groups.r2["Workers R2 Storage Bucket Item Write"].id },
    ]
    resources = jsonencode({
      "com.cloudflare.edge.r2.bucket.*" = "*"
    })
  }]
}

resource "cloudflare_api_token" "spacelift" {
  name = "spacelift-nikitabarskov"
  policies = [
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_api_token_permission_groups.user["API Tokens Read"].id },
        { id = local.cloudflare_api_token_permission_groups.user["API Tokens Write"].id },
        { id = local.cloudflare_api_token_permission_groups.user["User Details Read"].id },
      ]
      resources = jsonencode({
        "com.cloudflare.api.user.${data.cloudflare_user.me.id}" = "*"
      })
    },
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_api_token_permission_groups.account["Account API Tokens Read"].id },
        { id = local.cloudflare_api_token_permission_groups.account["Account API Tokens Write"].id },
        { id = local.cloudflare_api_token_permission_groups.account["Account Settings Read"].id },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
      })
    },
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_api_token_permission_groups.account["Account API Tokens Read"].id },
        { id = local.cloudflare_api_token_permission_groups.account["Account API Tokens Write"].id },
        { id = local.cloudflare_api_token_permission_groups.account["Account Settings Read"].id },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
      })
    },
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_api_token_permission_groups.zone["Zone Write"].id },
        { id = local.cloudflare_api_token_permission_groups.zone["Zone Settings Read"].id },
        { id = local.cloudflare_api_token_permission_groups.zone["Zone Settings Write"].id },
        { id = local.cloudflare_api_token_permission_groups.zone["DNS Read"].id },
        { id = local.cloudflare_api_token_permission_groups.zone["DNS Write"].id },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.zone.*" = "*"
      })
    },
  ]
  status = "active"
}
