{ inputs, config, lib, pkgs, ... }:
let
  nixGLIntel = inputs.nixGL.packages."${pkgs.system}".nixGLIntel;
in
{
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;
  home = {
    packages = with pkgs; [
      bat
      direnv
      fd
      fzf
      home-manager
      neovim
      nixGLIntel
      ripgrep
      tmux
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      (config.lib.nixGL.wrap wezterm)

      go

      # typescript / javascript
      nodejs
      nodePackages.typescript
      nodePackages.typescript-language-server
      yarn

      # python
      ruff
      python311
      python311Packages.pip
      python311Packages.python-lsp-server
    ];

    stateVersion = "23.11";

    file."./.config/omz-custom/my-theme.zsh-theme" = {
      source = ../config/my-zsh-theme;
    };

    file."./.config/wezterm/common.lua" = {
      source = ../config/wezterm/common.lua;
    };
  };

  imports = [
# todo: remove when https://github.com/nix-community/home-manager/pull/5355 gets merged:
    (builtins.fetchurl {
     url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
     sha256 = "0g5yk54766vrmxz26l3j9qnkjifjis3z2izgpsfnczhw243dmxz9";
     })
  ];

  nixGL.prefix = "${nixGLIntel}/bin/nixGLIntel";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
    '';
    syntaxHighlighting = {
      enable = true;
    };
    shellAliases = {
      "gd" = "git diff --color";
      "gdc" = "git diff --cached --color";
      "gs" = "git status";
      "gc" = "git commit";
      "ga" = "git add";
      "gpr" = "git pull --rebase";
      "ls" = "ls -G";
      "s" = "rg -S";
      "vim" = "nvim";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "direnv"
        "z"
      ];
      custom = "$HOME/.config/omz-custom";
      theme = "my-theme";
    };
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
    defaultCommand = "rg -S";
    defaultOptions = [
      "--preview 'bat --style=numbers --color=always {}'"
    ];
  };

  programs.git = {
    enable = true;
    userEmail = "87551537+AyMeeko@users.noreply.github.com";
    userName = "AyMeeko";
  };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";
    extraConfig = builtins.readFile ../config/tmux.conf;
  };
}
