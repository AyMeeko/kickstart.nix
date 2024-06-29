{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      bat
      fzf
      home-manager
      neovim
      ripgrep
      tmux
    ];

    stateVersion = "23.11";
  };
}
