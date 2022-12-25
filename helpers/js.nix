# JavaScript development tools

{ config, pkgs, ... }:
let
  unstable = (import ./unstable.nix);
  node16Packages = (unstable.nodePackages.override { nodejs = unstable.nodejs-16_x; });
in
{
  home.packages = [
    unstable.nodejs
    node16Packages.pnpm
  ];
}
