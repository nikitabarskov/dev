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

data "cloudflare_account_permission_groups" "all" {
  account_id = local.cloudflare_account_id
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
  cloudflare_account_permission_groups = {
    for permission_group in data.cloudflare_account_permission_groups.all.result :
    permission_group.name => permission_group
  }
}

moved {
  from = cloudflare_account_token.spacelift
  to   = cloudflare_account_token.barskov_dev
}

resource "cloudflare_account_token" "barskov_dev" {
  account_id = local.cloudflare_account_id
  name       = "spacelift-barskov-dev"
  policies = [{
    effect = "allow"
    permission_groups = [
      { id = local.cloudflare_api_token_permission_groups.account["Account Settings Read"].id },
      { id = local.cloudflare_api_token_permission_groups.account["Workers R2 Storage Write"].id },
    ]
    resources = {
      "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
    }
  }]
}

/* API Token used in this Stack */
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
      resources = {
        "com.cloudflare.api.user.${data.cloudflare_user.me.id}" = "*"
      }
    },
    {
      effect = "allow"
      permission_groups = [
        { id = local.cloudflare_api_token_permission_groups.account["Account API Tokens Read"].id },
        { id = local.cloudflare_api_token_permission_groups.account["Account API Tokens Write"].id },
        { id = local.cloudflare_api_token_permission_groups.account["Account Settings Read"].id },
      ]
      resources = {
        "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
      }
    }
  ]
  status = "active"
}
