# dev

Personal infrastructure and tooling repository.

## Agent Instructions

### Build & test

```sh
# Install all tools
just configure

# Lint and format check
just validate

# Auto-fix formatting
just fix
```

### Conventions

- Tools are managed via [mise](https://mise.jdx.dev/); see `mise.toml` for the
  tool list.
- Tasks are defined in `justfile`; use `just` to list available commands.
- GitHub Actions workflows are linted with
  [zizmor](https://github.com/woodruffw/zizmor).
- Dockerfiles are linted with [hadolint](https://github.com/hadolint/hadolint).
- Infrastructure is managed with [OpenTofu](https://opentofu.org/).

### Container images (`container-images/`)

Two images are maintained:

| Image              | Base                                          | Purpose                                   |
| ------------------ | --------------------------------------------- | ----------------------------------------- |
| `base-ci`          | `fedora:44`                                   | CI runner with mise pre-installed         |
| `spacelift-runner` | `spacelift/runner-terraform` + `1password/op` | Spacelift stack runner with 1Password CLI |

Images are tagged with both `latest` and the full git SHA, and pushed to
`ghcr.io/nikitabarskov/<target>` on merge to `main`.

```sh
# Lint a Dockerfile
cd container-images && just validate <target>

# Build both platforms locally (no push)
cd container-images && just build <target>

# Build + push (CI path)
cd container-images && just ci <target>
```

- Images must build for `linux/amd64` and `linux/arm64`.
- Pin base image digests (`@sha256:...`) — do not use floating tags.
- Lint Dockerfiles with `hadolint` before committing.

### Infrastructure (`infrastructure/opentofu/`)

OpenTofu manages cloud resources (Cloudflare, GitHub, GitLab, Spacelift,
1Password). Plans run via
[Spacelift](https://nikitabarskov.app.spacelift.io/stack/dev); `apply` is not
run locally.

```sh
cd infrastructure/opentofu

# Install tools and init (no backend)
just configure

# Format check + validate
just validate

# Auto-format
just fix

# Local preview via Spacelift CLI
just plan
```

- Requires a `.env` file with
  `CLOUDFLARE_API_TOKEN="op://<1password-reference>"`.
- Run `op run -- just <cmd>` to inject secrets from 1Password when needed.
- Backend is disabled for local runs (`tofu init -backend=false`).

### CI (`.github/workflows/`)

| Workflow                       | Trigger                   | What it does                                                                                                    |
| ------------------------------ | ------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `ci.yaml`                      | push/PR on relevant paths | Orchestrator: runs path-filter, fans out to `container-images` and `infrastructure-opentofu` reusable workflows |
| `container-images.yaml`        | called by `ci.yaml`       | Builds (PR) or builds+pushes (main) the target image                                                            |
| `infrastructure-opentofu.yaml` | called by `ci.yaml`       | Runs `mise install && just ci` inside `base-ci` container                                                       |

- The `setup` job uses `dorny/paths-filter` to determine which jobs actually
  run; only changed paths trigger downstream jobs (unless shared files like
  `mise.toml` changed, which triggers all).
- All workflow actions are pinned by SHA.
- Workflows are linted with `zizmor`; run `just validate` from the repo root.

### Repo-specific notes

- Always run `mise lock --platform linux-x64 --platform macos-arm64` after
  updating tool versions to keep the lock file consistent across platforms.
