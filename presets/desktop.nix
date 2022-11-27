{ config, pkgs, ... }:

{
  imports = [
    ./cli.nix
    ./common.nix
    ../helpers/desktop-apps.nix
    ../helpers/gnome.nix
    ../helpers/fonts.nix
    ../helpers/hidpi.nix
  ];
}
