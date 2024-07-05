{ config, lib, pkgs, ... }:

let
  cfg = config.services.kmonad;
in
{
  options.services.kmonad = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Kmonad service.";
    };

    configFile = lib.mkOption {
      type = lib.types.path;
      description = "Path to the Kmonad configuration file.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.kmonad = {
      Unit = {
        Description = "Run Kmonad";
      };
      Service = {
        ExecStart = "${pkgs.haskellPackages.kmonad}/bin/kmonad ${cfg.configFile}";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
