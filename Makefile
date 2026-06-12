# Define the function/template for the rebuild and commit logic
define rebuild_and_commit
	sudo nixos-rebuild switch --flake ./#$(1) && \
	git add . && \
	git commit -m "nixos-rebuild: updated $(1)"
endef

# # The % acts as a wildcard matching any target name you type
# %:
# 	@$(call rebuild_and_commit,$@)

HOSTS := lenny holly

# This only matches targets that are explicitly listed in the HOSTS variable
$(HOSTS):
	@$(call rebuild_and_commit,$@)

.PHONY: $(HOSTS)