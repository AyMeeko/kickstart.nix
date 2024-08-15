{ config, lib, pkgs, inputs, ... }:
{
  home = {
    username = "aymeeko";
    homeDirectory = "/home/aymeeko";
    packages = with pkgs; [
      copyq
      gnumake
      gnused
      jq
      xsel
    ];
  };
}
