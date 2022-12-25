{ config, pkgs, ... }:
let
  unstable = (import ./unstable.nix);
  ms-edge-wayland = import ../apps/ms-edge-wayland.nix { inherit config pkgs; };
  utybonur = (import ./utybonur.nix { inherit pkgs; });
in
{
  home.packages = [
    # Small utilities
    pkgs.gnome.gnome-tweaks
    pkgs.pavucontrol

    # Communication apps
    unstable.slack
    unstable.discord

    # Random apps
    pkgs.spotify
    pkgs.inkscape
    pkgs.libreoffice
    pkgs.yubikey-manager-qt
    pkgs.google-chrome
    unstable.newsflash
    ms-edge-wayland
    pkgs.vlc
    unstable.realvnc-vnc-viewer
    pkgs.gnome.dconf-editor
    pkgs.gnome-solanum

    utybonur.kuro
    utybonur.git-credential-manager
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland.override {
      cfg = {
        enableGnomeExtensions = true;
      };
    };
  };
}
