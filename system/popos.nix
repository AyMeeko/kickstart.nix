{ inputs, config, pkgs, username, ... }:
{
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      _1password-gui
      bruno
      copyq
      gnumake
      gnused
      home-manager
      kmonad
      obsidian
      xsel
    ];

    file."./.ssh/config" = {
      source = ../ssh/popos;
    };

    file."./.config/kmonad.kbd" = {
      source = ../config/kmonad.kbd;
    };
  };

  imports = [
    # todo: remove when https://github.com/nix-community/home-manager/pull/5355 gets merged:
    (builtins.fetchurl {
     url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
     sha256 = "1krclaga358k3swz2n5wbni1b2r7mcxdzr6d7im6b66w3sbpvnb3";
     })
  ];

  nixGL = {
    packages = inputs.nixGL.packages."${pkgs.system}";
    defaultWrapper = "mesa";
  };

  programs.git = {
    userEmail = "87551537+AyMeeko@users.noreply.github.com";
    userName = "AyMeeko";
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
