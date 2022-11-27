{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.arduino
  ];
}
