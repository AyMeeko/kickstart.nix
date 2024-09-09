{
  description = "Kickstart Nix on macOS and Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:nix-community/nixGL/310f8e49a149e4c9ea52f1adf70cdc768ec53f8a";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    flake-parts,
    darwin,
    home-manager,
    nixGL,
    ...
  }: let
  in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        darwinConfigurations = {
          macmini-nix = let
            username = "nix";
            system = "x86_64-darwin";
          in
            darwin.lib.darwinSystem {
              inherit system;
              specialArgs = { inherit inputs username; };
              modules = [
                ./module/darwin-configuration.nix
                home-manager.darwinModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.extraSpecialArgs = { inherit inputs; };
                  home-manager.users."${username}" = { pkgs, ... }: {
                    imports = [
                      ./system/x86_64-darwin.nix
                      ./module/home-manager.nix
                    ];
                  };
                }
              ];
            };
        };
        homeConfigurations = {
          popos = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            modules = [
              ./system/popos.nix
              ./module/home-manager.nix
            ];
            extraSpecialArgs = {
              inherit inputs;
              username = "aymeeko";
            };
          };
        };

        lib = import ./lib {inherit inputs;};
      };

      systems = ["x86_64-darwin" "x86_64-linux"];

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;

        packages = {
          fonts = self.lib.fonts {inherit (pkgs) stdenvNoCC;};
        };
      };
    };
}
