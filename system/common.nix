{ inputs, config, lib, pkgs, ... }:
let
  nixGLIntel = inputs.nixGL.packages."${pkgs.system}".nixGLIntel;
in
{
  fonts.fontconfig.enable = true;
  home = {
    packages = with pkgs; [
      bat
      fd
      fzf
      home-manager
      nixGLIntel
      ripgrep
      tmux
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      (config.lib.nixGL.wrap wezterm)
    ];

    stateVersion = "23.11";

    file."./.config/nvim/" = {
      source = ../config/nvim;
      recursive = true;
    };
  };

  imports = [
# todo: remove when https://github.com/nix-community/home-manager/pull/5355 gets merged:
    (builtins.fetchurl {
     url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
     sha256 = "11f3pnkb1a4glghpgqhrd2mv02x8rraqa798hvi7zipj1874zjl2";
     })
  ];

  nixGL.prefix = "${nixGLIntel}/bin/nixGLIntel";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      "vim" = "nvim";
    };
    syntaxHighlighting = {
      enable = true;
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      # Included to build telescope-fzf-native.nvim
      pkgs.cmake
      # Included for LuaSnip
      pkgs.luajitPackages.jsregexp
    ];
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    vimdiffAlias = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    colors = {
      bg = "#24273a";
      "bg+" = "#363a4f";
      spinner = "#f4dbd6";
      hl = "#ed8796";
      fg = "#cad3f5";
      header = "#ed8796";
      info = "#c6a0f6";
      pointer = "#f4dbd6";
      marker = "#f4dbd6";
      "fg+" = "#cad3f5";
      prompt = "#c6a0f6";
      "hl+" = "#ed8796";
    };
    defaultOptions = [
      "--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
      "--preview 'cat {}'"
    ];
  };

  programs.git = {
    enable = true;
    aliases = {
      gc = "git commit";
      gs = "git status";
      gdc = "git diff --cached";
      gd = "git diff";
    };
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = builtins.readFile ../config/wezterm.lua;
    package = (config.lib.nixGL.wrap pkgs.wezterm);
  };
}
