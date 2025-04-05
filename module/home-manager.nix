{ inputs, pkgs, pkgs-unstable, config, ... }: let
  premium-fonts = inputs.self.packages.${pkgs.system}.fonts;
in {
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.05";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    bat
    delta
    dig
    fd
    fzf
    gnumake
    gnused
    jq
    premium-fonts
    ripgrep
    tree
    unixtools.watch
    wget

    # nix lsp
    cargo
    nil

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

    file."./.config/omz-custom/my-theme.zsh-theme" = {
      source = ../config/my-zsh-theme;
    };

    file."./.config/tmux" = {
      source = ../config/tmux;
      recursive = true;
    };
  };

  programs.gpg.enable = true;

  xdg.configFile = {
    nvim = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/kickstart.nix/config/nvim";
      recursive = true;
    };
  };

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
        # noisy -- "error: daemon terminated"
        fsmonitor = false;
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

  programs.neovim = {
    package = pkgs-unstable.neovim-unwrapped;
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
      "ls" = "ls --color";
      "s" = "rg -S";
      "vim" = "nvim";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "direnv"
      ];
      custom = "$HOME/.config/omz-custom";
      theme = "my-theme";
    };
  };
}
