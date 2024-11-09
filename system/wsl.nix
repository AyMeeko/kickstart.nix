{ inputs, config, pkgs, username, ... }:
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
    ];
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
    defaultWrapper = "mesa"; # this might be wrong
  };

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
