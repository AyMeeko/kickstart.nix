.PHONY: popos
popos:
	home-manager switch --flake .#popos

.PHONY: wsl
wsl:
	home-manager switch --flake .#wsl

.PHONY: clean
clean:
	nix-collect-garbage -d
