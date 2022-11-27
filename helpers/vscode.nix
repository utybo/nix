{ config, pkgs, ... }:

let
  unstable = (import ./unstable.nix).unstable;
in
{
  programs.vscode = {
    enable = true;
    package = unstable.vscode;
    extensions = [ unstable.vscode-extensions.ms-vscode.cpptools ];
  };
}
