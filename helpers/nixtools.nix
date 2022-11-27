# Tools for dev of Nix on NixOS
{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.nixpkgs-fmt
    pkgs.rnix-lsp
  ];
}
