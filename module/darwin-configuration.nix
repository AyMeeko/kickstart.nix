{
  nixpkgs,
  pkgs,
  lib,
  username,
  ...
}: {
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

  environment = {
    shells = [pkgs.zsh];
    loginShell = pkgs.zsh;
    systemPackages = [
      pkgs.gnused
    ];
  };

  system = {
    defaults = {
      dock.autohide = true;
      NSGlobalDomain."com.apple.swipescrolldirection" = false;
      ".GlobalPreferences"."com.apple.mouse.scaling" = 0.125;
    };
  };

  programs.zsh.enable = true;

  services.nix-daemon.enable = true;

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
    ];
}
