.PHONY: validate
validate:
	terraform validate
	terraform fmt -check -diff -recursive .

.PHONY: validate-fix
validate-fix:
	terraform fmt -diff -recursive .
