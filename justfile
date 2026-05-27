set dotenv-load
set unstable

default:
    just --list

mise-upgrade target="":
    mise upgrade --bump {{ target }}

mise-lock:
    mise lock --platform linux-x64 --platform macos-arm64

configure:
    mise install

fix:
    mise fmt
    just --fmt

validate:
    mise fmt --check
    just --fmt --check
