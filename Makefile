.PHONY: update
update:
	home-manager switch --flake .#aymeeko

.PHONY: clean
clean:
	nix-collect-garbage -d
