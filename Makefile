DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore .gitmodules .travis.yml .idea .github .envrc
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

all: brew aqua install

brew: ## Install brew
	@sh ./etc/scripts/brew.sh
	@brew bundle

aqua: ## Install aqua
	@sh ./etc/scripts/aqua.sh

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

install: ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)


clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

lint-setup: ## Install and setup pre-commit hooks
	@echo '==> Setting up pre-commit hooks...'
	@pre-commit install
	@echo 'Pre-commit hooks installed!'

lint: ## Run pre-commit on all files
	@echo '==> Running pre-commit on all files...'
	@pre-commit run --all-files

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
