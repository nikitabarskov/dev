ROOT := $(shell pwd)

dev: ## Run blog in development mode
	docker compose up dev

app: ## Run blog in production mode
	docker compose up app

help: ## Print this text
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
