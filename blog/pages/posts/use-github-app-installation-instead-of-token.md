---
title: GitHub App Installation for OpenTofu
date: 2024-02-18
description: Utilize GitHub App Installation instead of Personal Access Tokens (PATs)
author: Nikita Barskov
tag: infrastructure as code, github, opentofu, spacelift
---

# GitHub App Installation for OpenTofu

This guide outlines transitioning from PATs to GitHub App Installation when
managing GitHub resources with OpenTofu.

## Motivation

Using a PAT with my personal GitHub account has been my norm. However, I find
GitHub Apps more efficient for managing GitHub resources within organizations.

## Prerequisites

Ensure the following are in place before proceeding:

-   GitHub organization
-   Repository for OpenTofu code within the organization
-   Spacelift account
-   Stack connected to the repository within the organization
-   OpenTofu installed on your machine

## Implementation

Follow these steps to set up the GitHub App.

### Create a GitHub Application

Refer to GitHub's documentation on ["Installing your own GitHub App"][gh-docs-install-gh-app]
for detailed instructions.

[gh-docs-install-gh-app]: https://docs.github.com/en/apps/using-github-apps/installing-your-own-github-app

Provide the following information:

-   Name: **opentofu-gh-provider-app**
-   Homepage URL: **https://github.com/skov-bar**
-   Disable WebHooks
-   Adjust permissions based on your requirements

#### Configuring permissions for GitHub App

Depending on your OpenTofu configuration scope, your GitHub App requires
different permissions. Review the most used permissions in GitHub's documentation
["Endpoints available for GitHub App installation access tokens"][gh-docs-gh-app-endpoints].

[gh-docs-gh-app-endpoints]: https://docs.github.com/en/rest/authentication/endpoints-available-for-github-app-installation-access-tokens?apiVersion=2022-11-28

Grant `administration: write` and `metadata: read` for repository permissions.
You can manage permissions in your GitHub App settings.

#### Install the application in your organization

Once created, navigate to:
`https://github.com/organizations/<change-me-org-name>/settings/apps/<change-me-org-name>/installations`,
click **Install**, and follow the prompts.

### Configure GitHub OpenTofu Provider

#### Configure Spacelift environment variables

Follow the official documentation on
["`integrations/github` GitHub App Installation"][tf-docs-gh-app-installation]
to set up the provider.

[tf-docs-gh-app-installation]: https://registry.terraform.io/providers/integrations/github/latest/docs#github-app-installation

Obtain GitHub App ID and GitHub Installation ID from the App settings page.
Create environment variables in your Spacelift Stack:

1. Create `TF_VAR_github_app_id` variable and set your GitHub App ID
2. Create `TF_VAR_github_app_installation_id` variable and set your GitHub App
   installation ID
3. Create a PEM Key, encode it using `base64`, and set it as a secret in
   `TF_VAR_github_app_pem_file`.

#### Add and configure OpenTofu GitHub provider

Update `terraform.required_providers` in `versions.tf`:

```hcl
github = {
  source  = "integrations/github"
  version = "~> 6.0"
}
```

Configure `providers.tf`:

```hcl
provider "github" {
  owner = "change-me-github-organisation-name"
  app_auth {
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    pem_file        = base64decode(var.github_app_pem_file)
  }
}
```

#### Create a PR to import existing repository

As an example, I've imported `skov-bar/platform` repository using Spacelift and
OpenTofu in this [PR][example-pr].

[example-pr]: https://github.com/skov-bar/platform/pull/1
