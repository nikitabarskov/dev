locals {
  onepassword_vault_id = "vziyx5bhfpu4o7xtla6zsaer6q"
}

data "onepassword_vault" "dev" {
  name = "dev"
}

resource "onepassword_item" "spacelift" {
  vault    = data.onepassword_vault.dev.uuid
  title    = "spacelift-dev"
  category = "login"
  section {
    label = "Environment Variables"
    field {
      label = "CLOUDFLARE_API_TOKEN"
      value = cloudflare_account_token.spacelift.value
      type  = "CONCEALED"
    }
  }
}

resource "onepassword_item" "r2" {
  vault    = data.onepassword_vault.dev.uuid
  title    = "r2-credentials"
  category = "login"
  section {
    label = "Credentials"
    field {
      label = "S3_ACCESS_KEY"
      value = cloudflare_account_token.github_actions_barskov_dev.id
      type  = "STRING"
    }
    field {
      label = "S3_SECRET_KEY"
      value = sha256(cloudflare_account_token.github_actions_barskov_dev.value)
      type  = "CONCEALED"
    }
  }
}
