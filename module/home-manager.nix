{ inputs, pkgs, config, ... }: let
  premium-fonts = inputs.self.packages.${pkgs.system}.fonts;
in {
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.11";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    bat
    delta
    fd
    premium-fonts
    fzf
    jq
    gnused
    ripgrep
    tree
    wget

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

  home = {
    file."./.config/wezterm/common.lua" = {
      source = ../config/wezterm/common.lua;
    };
  };

  programs.gpg.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    lfs = {
      enable = true;
    };
    extraConfig = {
      branch.sort = "-committerdate";
      column.ui = "auto";
      core = {
        editor = "nvim";
        fsmonitor = true;
        pager = "delta";
      };
      fetch = {
        prune = true;
        writeCommitGraph = true;
      };
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/key.pub";
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.updateRefs = true;
      rerere.enabled = true;
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
      "--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
      "--preview 'cat {}'"
    ];
  };

  # xdg.configFile = {
  #   nvim = {
  #     source = config.lib.file.mkOutOfStoreSymlink ../config/nvim;
  #     recursive = true;
  #   };
  # };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = ''
    '';
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

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";
    extraConfig = builtins.readFile ../config/tmux.conf;
    plugins = [
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
    '';
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
      theme = "robbyrussell";
    };
  };
}