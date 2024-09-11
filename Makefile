.PHONY: initialize-darwin
initialize-darwin:
	@if [ "$$TARGET" == "" ]; then \
		echo "Must supply TARGET. Use one of the following:"; \
		echo "    TARGET=macmini-aymeeko make initialize-darwin"; \
		echo "    TARGET=macmini-amy make initialize-darwin"; \
		exit 0; \
	fi
	nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake .#$$TARGET

.PHONY: popos
popos:
	home-manager switch --flake .#popos

.PHONY: wsl
wsl:
	home-manager switch --flake .#wsl

.PHONY: macmini-aymeeko
macmini-aymeeko:
	darwin-rebuild switch --flake .#macmini-aymeeko

.PHONY: clean
clean:
	nix-collect-garbage -d
