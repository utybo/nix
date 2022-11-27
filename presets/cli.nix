{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ../helpers/cli-tools.nix
    ../helpers/git.nix
    ../helpers/man-pages.nix
    ../helpers/shell.nix
  ];
}
