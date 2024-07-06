{ config, lib, pkgs, inputs, ... }:
{
  home = {
    username = "aymeeko";
    homeDirectory = "/home/aymeeko";
    packages = with pkgs; [
      copyq
      gnused
      haskellPackages.kmonad
      xclip
    ];

    file."./.config/kmonad.kbd" = {
      source = ../config/kmonad.kbd;
    };
  };

  services.kmonad = {
    enable = true;
    configFile = ../config/kmonad.kbd;
  };
}
