.PHONY: initialize-darwin-amy
initialize-darwin-amy:
	nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake .#macmini-amy

.PHONY: initialize-darwin-aymeeko
initialize-darwin-aymeeko:
	nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake .#macmini-aymeeko

.PHONY: popos
popos:
	home-manager switch --flake .#popos

.PHONY: wsl
wsl:
	home-manager switch --flake .#wsl

.PHONY: macmini-aymeeko
macmini-aymeeko:
	darwin-rebuild switch --flake .#macmini-aymeeko

.PHONY: macmini-amy
macmini-amy:
	darwin-rebuild switch --flake .#macmini-amy

.PHONY: clean
clean:
	nix-collect-garbage -d
