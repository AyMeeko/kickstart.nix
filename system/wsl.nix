{ inputs, config, pkgs, username, ... }:
{
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      tmuxPlugins.catppuccin
      copyq
      (inputs.nixGL.packages.x86_64-linux.nixGLIntel)
      gh
      gnumake
      gnused
      home-manager
      xsel
    ];
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
