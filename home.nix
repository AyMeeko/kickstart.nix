{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
      home-manager
    ];

    username = "aymeeko";
    homeDirectory = "/home/aymeeko";

    stateVersion = "23.11";
  };
}
