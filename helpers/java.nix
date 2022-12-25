# Java/Kotlin development tools
{ config, pkgs, ... }:

let
  unstable = (import ./unstable.nix);
  utybonur = (import ./utybonur.nix { inherit pkgs; });
in
{
  home.packages = [
    pkgs.jbang
    pkgs.jdk17
    pkgs.maven
    pkgs.bind
    unstable.gradle
    utybonur.jetbrains.idea-ultimate
  ];
}
