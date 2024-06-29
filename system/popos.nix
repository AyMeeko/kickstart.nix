{ lib, pkgs, inputs, ... }:
{
  home = {
    username = "aymeeko";
    homeDirectory = "/home/aymeeko";
    packages = with pkgs; [
      gnused
      xclip
    ];
  };
}
