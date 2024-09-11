{ inputs, pkgs, config, ... }: let
  premium-fonts = inputs.self.packages.${pkgs.system}.fonts;
in {
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.05";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    bat
    delta
    fd
    fzf
    gnumake
    gnused
    jq
    oh-my-posh
    premium-fonts
    ripgrep
    tree
    wget
    zoxide
    zsh-fzf-tab

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

  xdg.configFile = {
    "oh-my-posh" = {
      source = ../config/oh-my-posh;
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
    ];
    # CTRL-T keybind options
    fileWidgetOptions = [
      "--preview 'bat --style=numbers --color=always {}'"
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
    extraPackages = [
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

  programs.zoxide.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 5000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      share = true;
      save = 5000;
    };
    initExtra = ''
      source "${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"

      # History options
      setopt appendhistory
      setopt sharehistory
      setopt hist_ignore_space
      setopt hist_ignore_all_dups
      setopt hist_save_no_dups
      setopt hist_ignore_dups
      setopt hist_find_no_dups

      # Stolen from oh-my-zsh
      ## https://github.com/ohmyzsh/ohmyzsh/blob/80fa5e137672a529f65a05e396b40f0d133b2432/lib/directories.zsh#L10
      setopt auto_cd
      setopt auto_pushd
      setopt pushd_ignore_dups
      setopt pushdminus

      # Keybindings
      bindkey -e
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^[w' kill-region

      # Completion styling
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

      autoload -U compinit; compinit

      # To customize prompt
      #eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/zen.toml)"
      eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/mine.toml)"

      # Shell integrations
      eval "$(${pkgs.fzf}/bin/fzf --zsh)"
      eval "$(${pkgs.zoxide}/bin/zoxide init --cmd cd zsh)"
      enable-fzf-tab
    '';
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
      }
    ];
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
      "..." = "../..";
    };
  };
}
