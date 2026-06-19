set dotenv-load
set unstable

default:
    just --list

upgrade target="":
    mise upgrade --bump {{ target }}

lock:
    mise lock --platform linux-x64 --platform macos-arm64

use target:
    mise use {{ target }}

configure:
    mise install

fix:
    mise fmt
    just --fmt
    oxfmt --write
    zizmor --fix=all .github/workflows
    tflint --recursive

validate:
    mise fmt --check
    just --fmt --check
    oxfmt --check
    zizmor .github/workflows
    tflint --recursive
    trivy config .
