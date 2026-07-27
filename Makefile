# Define the function with two arguments: $(1) for the host, $(2) for the message
define rebuild_and_commit
	sudo nixos-rebuild switch --flake ./#$(1) && \
	git add . && \
	git commit -m "$(if $(2),$(2),nixos-rebuild: updated $(1))"
endef

# # The % acts as a wildcard matching any target name you type
# %:
# 	@$(call rebuild_and_commit,$@)

# Only allow matches that are explicitly listed in the HOSTS variable
HOSTS := lenny holly

# Allow passing a message via 'msg' variable (e.g., make holly msg="fix graphics driver")
$(HOSTS):
	@$(call rebuild_and_commit,$@,$(msg))

.PHONY: $(HOSTS)

.PHONY: update
update:
	nix flake update nixpkgs nixpkgs-unstable nixpkgs-deprecated home-manager

.PHONY: clean
clean:
	nix-collect-garbage -d
