{ inputs, config, pkgs, username, ... }:
let
  nixGLIntel = inputs.nixGL.packages."${pkgs.system}".nixGLIntel;
in
{
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      copyq
      gnumake
      gnused
      home-manager
      xsel
      (config.lib.nixGL.wrap wezterm)
    ];
  };

  imports = [
    # todo: remove when https://github.com/nix-community/home-manager/pull/5355 gets merged:
    (builtins.fetchurl {
     url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
     sha256 = "0g5yk54766vrmxz26l3j9qnkjifjis3z2izgpsfnczhw243dmxz9";
     })
  ];

  nixGL.prefix = "${nixGLIntel}/bin/nixGLIntel";

  programs.git = {
    userEmail = "87551537+AyMeeko@users.noreply.github.com";
    userName = "AyMeeko";
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = builtins.readFile ../config/wezterm/wsl.lua;
    package = (config.lib.nixGL.wrap pkgs.wezterm);
  };
}
