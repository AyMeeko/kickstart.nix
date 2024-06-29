{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      bat
      home-manager
      gnused
      neovim
      ripgrep
      tree
    ];

    username = "aymeeko";
    homeDirectory = "/home/aymeeko";

    stateVersion = "23.11";
  };
}
