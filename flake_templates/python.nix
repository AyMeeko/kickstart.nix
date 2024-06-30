{
  description = "Python 3.9 development environment";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11"; };

  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs.lib) genAttrs;
      supportedSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      forAllSystems = f: genAttrs supportedSystems (system: f system);
    in {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.python39
              pkgs.python39Packages.pip
            ];
          };
        });
    };
}
