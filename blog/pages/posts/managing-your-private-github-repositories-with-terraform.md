# How can I use Terraform to manage my GitHub repositories

This article is highly inspired and overlaps with
**"Using Terraform to Manage Git Repositories"** by Chris Wahl.
You can also read [the original][using-terraform-to-manage-git-repositories]
text.

[using-terraform-to-manage-git-repositories]: https://wahlnetwork.com/2020/09/01/using-terraform-to-manage-git-repositories/

## Motivation

I want to learn and share my vision of working
with IaaC tooling like Terraform. Having my repositories
managed in an IaaC manner is also a good outcome.

## Prerequisites

Before you start, you need

- GitHub account,
- an empty GitHub repository,
- Terraform CLI.

## Structure of the repository

To be fair, at the moment of writing, I already had
a repository for all my personal development: this blog,
previous attempts to configure my personal GitHub
with Terraform, and etc.

After several iterations I realised, that the most convenient
for me layout should look like this:

```shell
.
├── README.MD
└── infrastructure
    └── terraform
```

`infrastructure` folder has all required and essential code
to manage my personal infrastructure: integration with Cloud Providers,
management my version control, and etc.

`terraform` is a tool specific subfolder for infrastructure.
I might want to test Pulumi or other IaaC tooling in the future
and this project structure allows me test it in a quite flexible
manner.

If you want to follow the suggested structure then run in the root of
you repository:

```shell
mkdir -p infrastructure/terraform
```

## Creating a boilerplate for our Terraform code

To configure Terraform to work with GitHub we need to:

- configure Terraform backend,
- configure GitHub Terraform provider.

### Configure Terraform backend and Terraform version

For simplicity, I started with [`local`][terraform-local-backend] backend.
It has its own downsides, but I can improve it later.

[terraform-local-backend]: https://developer.hashicorp.com/terraform/language/settings/backends/local

Create `backend.tf` file in `infrastructure/terraform` folder with
the following content:

```hcl title="backend.tf"
terraform {
  backend "local" {}
}
```

To configure preferred Terraform version I created `versions.tf`

```hcl title="versions.tf"
terraform {
  required_version = ">= 1.0"
}
```

### Configure Terraform providers

We need to configure [GitHub Integration][integrations-github-terraform-provider]
Terraform provider.

[integrations-github-terraform-provider]: https://registry.terraform.io/providers/integrations/github/5.9.1

First, let's add the provider. To do this, update the content of `versions.tf`
to:

```hcl title="versions.tf"
terraform {
  required_version = ">= 1.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.9"
    }
  }
}
```

GitHub Integration Terraform provider also requires [authentication][integrations-github-terraform-provider-authentication].
In this article, I am going to use token based authentication.

Create a file `providers.tf` and put these lines of code there

```hcl title="providers.tf"
provider "github" {
  owner = "<change-me-name-of-github-profile>"
  token = var.github_oauth_token
}
```

Instead of `<change-me-name-of-github-profile>` put your GitHub profile user name.
In my case it is `nikitabarskov`.

[integrations-github-terraform-provider-authentication]: https://registry.terraform.io/providers/integrations/github/latest/docs#authentication

As you can see we use [Terraform variables][terraform-variables] to cofigure provider.
I also used to configure them in a separate file `variables.tf`.

```hcl title="variables.tf"
variable "github_oauth_token" {
  type      = string
  sensitive = true
}
```

[terraform-variables]: https://developer.hashicorp.com/terraform/language/values/variables

## Run Terraform

Run a command

```shell
terraform init
```

and then

```shell
terraform plan
```

and you should able to see the expected output:

```shell
var.github_oauth_token
Enter a value:
```

You need to submit a PAT for GitHub. You can follow the instruction
["Creating a personal access token"][github-docs-creating-personal-access-token]
from GitHub. I will just list a set of permission I used, when I was creating
one: `admin:gpg_key`, `admin:org`, `admin:public_key`, `admin:repo_hook`,
`admin:ssh_signing_key`, `delete_repo`, `repo`, `user`.

[github-docs-creating-personal-access-token]: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token


Once you created a PAT, run `terraform plan` again, and submit the PAT as an input.

Great job!

## Import the repository

Let's bring your empty repository you are working in now to Terraform.

In my case I have a repository `dev` with some ClickOps chages made by me before.

First of all, I am trying to structure the things I am doing, and there are several
ways how you can structure your Terraform code. For me, the most suitable one is
to keep all Cloud resources related to the actual resource I am using together.

In case of GitHub repositories I am using a file called `github_repositories.tf`.

So, to import the repository to Terraform I do this list of actions:

1. I put these lines in `github_repositories.tf`

   ```hcl title="github_repositories.tf"
   resource "github_repository" "dev" {
     name = "dev"
   }
   ```

2. I import `dev` repository to Terraform state

   ```shell
   terraform import github_repository.dev dev
   ```

   It will ask you to submit your GitHub PAT again.
   The successfull output of `terraform import` command
   should look like that

   ```shell
   github_repository.dev: Importing from ID "dev"...
   github_repository.dev: Import prepared!
   Prepared github_repository for import
   github_repository.dev: Refreshing state... [id=dev]

   Import successful!

   The resources that were imported are shown above. These resources are now in
   your Terraform state and will henceforth be managed by Terraform.
   ```

3. I run `terraform plan` again to see the differences between
   the actual configuration and the configuration I described in my
   Terraform code.

   ```shell
   terraform plan
   ```

   And the output for me looks like

   ```shell
   github_repository.dev: Refreshing state... [id=dev]

   Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
     ~ update in-place

   Terraform will perform the following actions:

     # github_repository.dev will be updated in-place
     ~ resource "github_repository" "dev" {
         ~ allow_auto_merge            = true -> false
         ~ allow_merge_commit          = false -> true
         ~ delete_branch_on_merge      = true -> false
           id                          = "dev"
           name                        = "dev"
           ~ topics                      = [
               - "github",
               - "infrastructure",
               - "terraform",
           ]
           - vulnerability_alerts        = true -> null
           # (26 unchanged attributes hidden)
       }

    Plan: 0 to add, 1 to change, 0 to destroy.
    ```

4. I fix my Terraform code to aligh with the actual configuration

   ```hcl title="github_repositories.tf"
   resource "github_repository" "dev" {
     name = "dev"

     allow_auto_merge   = true
     allow_merge_commit = false
     allow_rebase_merge = true

     delete_branch_on_merge = true

     topics = [
       "github",
       "infrastructure",
       "terraform",
     ]

     vulnerability_alerts = true
   }
   ```

5. Run `terraform plan` again and paste your PAT again.
   The output should be close to the example below.

   ```shell
   github_repository.dev: Refreshing state... [id=dev]

   No changes. Your infrastructure matches the configuration.

   Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
   ```

6. **Optionally:** run `terraform apply` and check the output.

   ```shell
   Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

   Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
   ```

7. Commit your changes and push them to GitHub!

## Conclusion

Managing infrastructure with Terraform is not hard at all,
and even you can use it for your personal projects.

I learned how to use Terraform with GitHub, and how to
structure Terraform code.

In next articles, I will try to describe the usage of Terraform Cloud,
and how to configure CI for your Terraform code.

Happy Terraforming!

## Links

The changes you can find in my PR: [nikitbarskov/dev#217][nikita-barskov-dev-217].

[nikita-barskov-dev-217]: https://github.com/nikitabarskov/dev/pull/217
