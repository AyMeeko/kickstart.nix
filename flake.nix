{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:nix-community/nixGL/310f8e49a149e4c9ea52f1adf70cdc768ec53f8a";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixGL,
    ...
  }@inputs:
    {
      homeConfigurations = {
        wsl = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./system/wsl.nix
            ./system/common.nix
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
        popos = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./system/popos.nix
            ./modules/kmonad.nix
            ./system/common.nix
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
        macmini = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          modules = [
            ./system/darwin.nix
            ./system/common.nix
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
