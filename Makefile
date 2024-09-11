.PHONY: initialize-amy
initialize-amy:
	nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake .#amy

.PHONY: initialize-aymeeko
initialize-aymeeko:
	nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake .#aymeeko

.PHONY: popos
popos:
	home-manager switch --flake .#popos

.PHONY: wsl
wsl:
	home-manager switch --flake .#wsl

.PHONY: aymeeko
aymeeko:
	darwin-rebuild switch --flake .#aymeeko

.PHONY: amy
amy:
	darwin-rebuild switch --flake .#amy

.PHONY: clean
clean:
	nix-collect-garbage -d
