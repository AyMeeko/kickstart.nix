{ inputs, config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      wezterm
    ];

    file."./.config/wezterm/wezterm.lua" = {
      source = ../config/wezterm/x86_64-darwin.lua;
    };
  };

  programs.git = {
    userEmail = "87551537+AyMeeko@users.noreply.github.com";
    userName = "AyMeeko";
  };
}
