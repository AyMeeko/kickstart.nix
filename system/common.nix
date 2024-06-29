{ config, lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      bat
      fd
      fzf
      fzf-zsh
      gcc
      gnumake42
      home-manager
      ripgrep
      tmux
    ];

    stateVersion = "23.11";

    file."./.config/nvim/" = {
      source = ../config/nvim;
      recursive = true;
    };
  };

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
    #extraConfig = ":luafile ~/.config/nvim/init.lua";
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
}
