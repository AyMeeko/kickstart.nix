{ inputs, config, pkgs, lib, ... }:
{
  home = {
    packages = with pkgs; [
    ];

    file."./.config/wezterm/wezterm.lua" = {
      source = ../config/wezterm/x86_64-darwin.lua;
    };

    file."./.config/karabiner/karabiner.json" = {
      source = ../config/karabiner/karabiner.json;
    };

    activation = {
      removeExistingKarabiner = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
        rm -f ~/.config/karabiner/karabiner.json.backup
        '';
    };
  };

  programs.git = {
    userEmail = "87551537+AyMeeko@users.noreply.github.com";
    userName = "AyMeeko";
  };
}
