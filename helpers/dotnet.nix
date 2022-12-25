{ config, pkgs, ... }:
let
  unstable = (import ./unstable.nix);
in
{
  home.packages = [
    pkgs.dotnet-sdk
    unstable.jetbrains.rider
  ];
}
