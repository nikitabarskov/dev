# OpenTofu configuration of cloud resources for my personal use

See runs: https://nikitabarskov.app.spacelift.io/stack/dev

## .env

```text
CLOUDFLARE_API_TOKEN="op://<change-me-reference>"
```

## Links

- https://search.opentofu.org/
- https://search.opentofu.org/provider/cloudflare/cloudflare/v4.52.5
- https://github.com/cloudflare/terraform-provider-cloudflare/issues/6403

## Useful commands

### Fetch Cloudflare Account Permission Groups

```bash
op run --no-masking -- sh -c 'curl --silent "https://api.cloudflare.com/client/v4/accounts/a71133601c96b473ef65e3c9ea99d689/iam/permission_groups" --header "Authorization: Bearer ${CLOUDFLARE_API_TOKEN}"'
```
