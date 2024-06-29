{ lib, pkgs, ... }:
let
  username = "aymeeko";
in
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      bat
      home-manager
      gnused
      neovim
      ripgrep
      tree
    ];

    stateVersion = "23.11";
  };
}
