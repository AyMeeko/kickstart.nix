{
  description = "Kickstart Nix on macOS and Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-unstable,
    flake-parts,
    darwin,
    home-manager,
    nixGL,
    ...
  }:
  let
    pkgs-unstable = system: import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in
    flake-parts.lib.mkFlake { inherit inputs; }
    {
      flake = {
        darwinConfigurations = {
          aymeeko = let
            username = "aymeeko";
            system = "x86_64-darwin";
          in
            darwin.lib.darwinSystem {
              inherit system;
              specialArgs = { inherit inputs username; };
              modules = [
                ./module/darwin-configuration.nix
                {
                  homebrew = {
                    enable = true;
                    brews = [ "displayplacer" ];
                    casks = [ "chatterino" ];
                  };
                }
                home-manager.darwinModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.backupFileExtension = "backup";
                  home-manager.extraSpecialArgs = {
                    inherit inputs;
                    pkgs-unstable = pkgs-unstable system;
                  };
                  home-manager.users."${username}" = { pkgs, ... }: {
                    imports = [
                      ./system/aymeeko.nix
                      ./module/home-manager.nix
                    ];
                  };
                }
              ];
            };
          amy = let
            username = "amy";
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
                  home-manager.backupFileExtension = "backup";
                  home-manager.extraSpecialArgs = {
                    inherit inputs;
                    pkgs-unstable = pkgs-unstable system;
                  };
                  home-manager.users."${username}" = { pkgs, ... }: {
                    imports = [
                      ./system/amy.nix
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
              ./module/kmonad.nix
              ./module/home-manager.nix
            ];
            extraSpecialArgs = {
              inherit inputs nixGL;
              pkgs-unstable = pkgs-unstable "x86_64-linux";
              username = "aymeeko";
            };
          };
          wsl = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            modules = [
              ./system/wsl.nix
              ./module/home-manager.nix
            ];
            extraSpecialArgs = {
              inherit inputs nixGL;
              pkgs-unstable = pkgs-unstable "x86_64-linux";
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
