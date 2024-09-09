.PHONY: popos
popos:
	home-manager switch --flake .#popos

.PHONY: wsl
wsl:
	home-manager switch --flake .#wsl

.PHONY: macmini-nix
macmini-nix:
	darwin-rebuild switch --flake .#macmini-nix

.PHONY: clean
clean:
	nix-collect-garbage -d
