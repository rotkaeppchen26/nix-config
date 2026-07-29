# Define the function:
# $(1) = host
# $(2) = commit message (if provided)
# $(3) = local flag (if "true", skips commit)
define rebuild_and_commit
	sudo nixos-rebuild switch --flake ./#$(1)
	@if [ "$(3)" != "true" ]; then \
		git add . && \
		git commit -m "$(if $(2),$(2),nixos-rebuild: updated $(1))"; \
	else \
		echo "Skipping git commit (--local enabled)."; \
	fi
endef

HOSTS := lenny holly

# Allow passing a message via 'msg' and skipping via 'local=true'
# Example: make lenny msg="update flake" local=true
$(HOSTS):
	@$(call rebuild_and_commit,$@,$(msg),$(local))

.PHONY: $(HOSTS)

.PHONY: update
update:
	nix flake update nixpkgs nixpkgs-unstable nixpkgs-deprecated home-manager

.PHONY: clean
clean:
	nix-collect-garbage -d
