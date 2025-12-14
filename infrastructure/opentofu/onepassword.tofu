locals {
  onepassword_vault_id = "vziyx5bhfpu4o7xtla6zsaer6q"
}

resource "onepassword_item" "spacelift" {
  vault    = local.onepassword_vault_id
  title    = "spacelift"
  category = "login"
  section {
    label = "barskov.dev"
    field {
      label = "CLOUDFLARE_API_TOKEN"
      value = cloudflare_api_token.barskov_dev.value
      type  = "CONCEALED"
    }
  }
}

resource "onepassword_item" "r2" {
  vault    = local.onepassword_vault_id
  title    = "r2-credentials"
  category = "login"
  section {
    label = "Credentials"
    field {
      label = "S3_ACCESS_KEY"
      value = cloudflare_api_token.github_actions_barskov_dev.id
      type  = "STRING"
    }
    field {
      label = "S3_SECRET_KEY"
      value = sha256(cloudflare_api_token.github_actions_barskov_dev.value)
      type  = "CONCEALED"
    }
  }
}
