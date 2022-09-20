{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  imports = [
    ../helpers/hidpi.nix
  ];

  home.packages = [
    pkgs.micro
    unstable.discord
    pkgs.gnome.gnome-tweaks
    pkgs.slack
    pkgs.gh
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland.override {
      cfg = {
        enableGnomeExtensions = true;
      };
    };
  };
  programs.vscode.enable = true;

  programs.git = {
    enable = true;
    userName = "Zoroark";
    userEmail = "utybodev" + (builtins.elemAt [ "@" ] 0 ) + "gmail.com";
  };
}
