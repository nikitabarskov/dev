---
title: Use Terraform Cloud as a remote backend for managing your personal infrastructure
date: 2022-12-04
description: IaC approach to manage personal infrastructure with Terraform Cloud
author: Nikita Barskov
tag: infrastructure as code, github, terraform
---

# Use Terraform Cloud as a remote backend for managing your infrastructure

In the previous article I've been using a [`local`][terraform-local-backend] backend.
In this article I am describing why and how I use [Terraform Cloud][terraform-cloud]
and a [`remote`][terraform-remote-backend] backend.

[terraform-local-backend]: https://developer.hashicorp.com/terraform/language/settings/backends/local
[terraform-cloud]: https://developer.hashicorp.com/terraform/cloud-docs
[terraform-remote-backend]: https://developer.hashicorp.com/terraform/language/settings/backends/remote

## Motivation

I wanted to upgrade my setup and improve security.

I have two work machines: a personal notebook and
a personal workstation. Using a `local` backend, you
can't smoothly work from a different environment.
With a remote backend, I can solve this problem quickly.

I need to submit the credentials to access GitHub,
Vercel, GitLab and Terraform Cloud with my the current
setup as a CLI input or store them in a plain text file.

Terraform Cloud has sensitive variables and allows me to
prevent my secrets from being stored on my local machine.

## Prerequisites

You need:

-   a Terraform Cloud account,
-   Terraform CLI,
-   a repository with Terraform code configured to use local backend.

## Create a Terraform Cloud account and create PAT

Follow this [instruction][terraform-cloud-signup] to create
a Terraform Cloud account.

[terraform-cloud-signup]: https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-sign-up#create-an-account

Then [create a PAT][terraform-cloud-create-a-pat] and store it in
`terraform.tfvars` file as `tfe_token` along with others secrets:

```hcl copy showLineNumbers filename="terraform.tfvars"
github_oauth_token = "change-me-github-oauth-token"
tfe_token          = "change-me-tfe-token"
```

## Add and configure provider

I need to add [Terraform Cloud Provider][terraform-cloud-provider] to
`providers.tf` and `versions.tf`. Also, I should not forget about `tfe_token`
variable in `variables.tf`.

```hcl copy showLineNumbers filename="providers.tf"
provider "tfe" {
  token = var.tfe_token
}
```

```hcl copy showLineNumbers filename="versions.tf"
tfe = {
  source  = "hashicorp/tfe"
  version = "~> 0.39"
}
```

```hcl copy showLineNumbers filename="variables.tf"
variable "tfe_token" {
  type      = string
  sensitive = true
}
```

[terraform-cloud-provider]: https://registry.terraform.io/providers/hashicorp/tfe/latest

## Create organisation, connect VCS and configure a workspace

As I [discussed](managing-your-private-github-repositories-with-terraform#import-the-repository)
the naming of files with Terraform Code, I create a file `terraform_enterprise.tf`.
I will put all resources, related to Terraform Cloud.

### Create an organisation and connect VCS

In Terraform Cloud, an organisation is a collection of users, workspaces,
and other resources that you can use to manage your infrastructure as code.

Check [Terraform Cloud documentation][terraform-cloud-docs-organisation] for more.

[terraform-cloud-docs-organisation]: https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-sign-up#create-an-organization

I need to create one with [`tfe_organization`][tfe-organisation-resource] resource:

```hcl copy showLineNumbers filename="terraform_cloud.tf"
resource "tfe_organization" "main" {
  name  = "<change-me-name>"
  email = "<change-me-email>"
}
```

[tfe-organisation-resource]: https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization

And then `terraform apply -auto-approve`. Once Terraform successfully applies
the changes you should be able to access the page

```text copy
https://app.terraform.io/app/<change-me-name>/workspaces
```

Then connect your GitHub account to Terraform Cloud. It is super easy to do with
`tfe_oauth_client`.

```hcl copy showLineNumbers filename="terraform_cloud.tf"
resource "tfe_oauth_client" "github" {
  name             = "github"
  organization     = "<change-me-organisation-name>"
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_oauth_token
  service_provider = "github"
}
```

And then `terraform apply -auto-approve` again, wait for the apply and then check

```text copy
https://app.terraform.io/app/<change-me-organisation-name>/settings/version-control
```

### Create a workspace and configure secrets

In Terraform Cloud, a workspace is a logical container for your infrastructure
as code. It holds the configuration files, state, and other metadata for
your infrastructure.

We can use [`tfe_workspace`][tfe-workspace-resource] resource

[tfe-workspace-resource]: https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace

```hcl copy showLineNumbers filename="terraform_cloud.tf"
resource "tfe_workspace" "dev" {
  name              = "dev"
  organization      = tfe_organization.main.name
  working_directory = "/infrastructure/terraform"
  queue_all_runs    = false
  vcs_repo {
    identifier         = github_repository.dev.full_name
    oauth_token_id     = tfe_oauth_client.github.oauth_token_id
    ingress_submodules = false
  }
}
```

And configure secrets with [`tfe_variable`][tfe-variable].

[tfe-variable]: https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable

```hcl copy showLineNumbers filename="terraform_cloud.tf"
locals {
  tfe_variables = {
    github_oauth_token = var.github_oauth_token
    tfe_token          = var.tfe_token
  }
}

resource "tfe_variable" "variables" {
  for_each     = local.tfe_variables
  key          = each.key
  value        = each.value
  category     = "terraform"
  sensitive    = true
  workspace_id = tfe_workspace.dev.id
}
```

Again, `terraform apply -auto-approve`, wait, and then
you should be able to access

```text copy
https://app.terraform.io/app/<change-me-organisation-name>/workspaces/dev
```

## Switch backend

Change the content of `backend.tf` to

```hcl copy showLineNumbers filename="backend.tf"
terraform {
  backend "remote" {
    organization = "<change-me-organisation-name>"

    workspaces {
      name = "dev"
    }
  }
}
```

and then run

```copy
terraform init -migrate-state
```

And that's it!

## Conclusions

If you want to use Terraform Cloud as a remote backend, you can do it.
The configuration is straightforward and easy. There are several alternatives
to Terraform Cloud, like built-in Terraform state management in GitLab,
or you can use Google Cloud Storage as a remote backend too.

## Links

The changes you can find in my PR: [nikitbarskov/dev#240][nikita-barskov-dev-240].

[nikita-barskov-dev-240]: https://github.com/nikitabarskov/dev/pull/240
