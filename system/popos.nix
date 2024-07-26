{ config, lib, pkgs, inputs, ... }:
{
  home = {
    username = "aymeeko";
    homeDirectory = "/home/aymeeko";
    packages = with pkgs; [
      copyq
      gnused
      kmonad
      xsel
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
