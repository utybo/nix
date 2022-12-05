{ config, pkgs, ... }:
let
  unstable = (import ./unstable.nix).unstable;
in
{
  home.packages = [
    pkgs.python310
    pkgs.python310Packages.poetry
  ];
}
