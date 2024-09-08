{ config, lib, pkgs, inputs, ... }:
{
  home = {
    username = "aymeeko";
    homeDirectory = "/home/aymeeko";
    packages = with pkgs; [
      _1password-gui
      bruno
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

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = builtins.readFile ../config/wezterm/popos.lua;
    package = (config.lib.nixGL.wrap pkgs.wezterm);
  };
}
