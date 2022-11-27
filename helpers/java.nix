# Java/Kotlin development tools
{ config, pkgs, ... }:

let
  unstable = (import ./unstable.nix).unstable;
in
{
  home.packages = [
    pkgs.jbang
    pkgs.jdk17
    pkgs.maven
    pkgs.bind
    unstable.gradle
    unstable.jetbrains.idea-ultimate
  ];
}
