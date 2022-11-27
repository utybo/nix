{ config, pkgs, ... }:
{
  imports = [
    ../presets/desktop.nix
    ../presets/dev.nix
  ];
}
