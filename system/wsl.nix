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

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = builtins.readFile ../config/wezterm/wsl.lua;
    package = (config.lib.nixGL.wrap pkgs.wezterm);
  };
}
