{ inputs, config, pkgs, username, ... }:
let
  nixGLIntel = inputs.nixGL.packages."${pkgs.system}".nixGLIntel;
in
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
      xsel
      kmonad
      (config.lib.nixGL.wrap wezterm)
    ];

    file."./.config/kmonad.kbd" = {
      source = ../config/kmonad.kbd;
    };
  };

  imports = [
    # todo: remove when https://github.com/nix-community/home-manager/pull/5355 gets merged:
    (builtins.fetchurl {
     url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
     sha256 = "01dkfr9wq3ib5hlyq9zq662mp0jl42fw3f6gd2qgdf8l8ia78j7i";
     })
  ];

  nixGL.prefix = "${nixGLIntel}/bin/nixGLIntel";

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
