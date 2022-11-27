{ config, pkgs, ... }:
let
  unstable = (import ./unstable.nix).unstable;
in
{
  home.packages = [
    pkgs.dotnet-sdk
    unstable.jetbrains.rider
  ];
}
