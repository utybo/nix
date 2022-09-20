{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  imports = [
    ../helpers/hidpi.nix
    ../helpers/desktop.nix
  ];
}
