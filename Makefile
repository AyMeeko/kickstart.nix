.PHONY: update
update:
	home-manager switch --flake .#popos

.PHONY: clean
clean:
	nix-collect-garbage -d
