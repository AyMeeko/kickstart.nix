{
  nixpkgs,
  pkgs,
  lib,
  username,
  ...
}: {
  homebrew = {
    enable = true;
    casks = [
      "1password"
      "alfred"
      "arc"
      "bazecor"
      "bettertouchtool"
      "charmstone"
      "discord"
      "karabiner-elements"
      "slack"
      "spotify"
      "wezterm"
    ];
  };

  environment = {
    shells = [pkgs.zsh];
    loginShell = pkgs.zsh;
    systemPackages = [
      pkgs.gnused
    ];
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["flakes" "nix-command"];
      substituters = ["https://nix-community.cachix.org"];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = ["@wheel"];
      warn-dirty = false;
    };
  };
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
    ];

  programs.zsh.enable = true;
  services.nix-daemon.enable = true;

  system = {
    defaults = {
      dock.autohide = true;
      NSGlobalDomain."com.apple.swipescrolldirection" = false;
      NSGlobalDomain."com.apple.keyboard.fnState" = true;
      ".GlobalPreferences"."com.apple.mouse.scaling" = 0.125;
    };
  };

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };
}
