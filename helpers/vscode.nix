{ config, pkgs, ... }:

let
  unstable = (import ./unstable.nix);
  wlfix = import ./wlfix.nix;
in
{
  programs.vscode = {
    enable = true;
    package = (wlfix unstable unstable.vscode);
    extensions = [ unstable.vscode-extensions.ms-vscode.cpptools ];
  };
}
