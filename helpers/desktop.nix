{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  ms-edge-wayland = import ../apps/ms-edge-wayland.nix { inherit config pkgs; };
  node16Packages = (unstable.nodePackages.override { nodejs = unstable.nodejs-16_x; });
in
{
  imports = [
    ./hidpi.nix
    ./shell.nix
  ];

  home.packages = [
    # Small utilities
    pkgs.figlet
    pkgs.gh
    pkgs.gnome.gnome-tweaks
    pkgs.lolcat
    pkgs.micro
    pkgs.pavucontrol
    pkgs.wl-clipboard

    # Nix-related utilities
    pkgs.nixpkgs-fmt
    pkgs.rnix-lsp

    # Java dev tools
    pkgs.jbang
    pkgs.jdk17
    pkgs.maven
    unstable.jetbrains.idea-ultimate

    # Node dev tools
    unstable.nodejs
    node16Packages.pnpm

    # .NET dev tools
    pkgs.dotnet-sdk
    unstable.jetbrains.rider

    # Python dev tools
    pkgs.python310
    pkgs.python310Packages.poetry

    # Communication apps
    pkgs.slack
    unstable.discord

    # Random apps
    pkgs.spotify

    # Fonts
    pkgs.cascadia-code

    # Patched apps
    ms-edge-wayland
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland.override {
      cfg = {
        enableGnomeExtensions = true;
      };
    };
  };

  programs.vscode = {
    enable = true;
    package = unstable.vscode;
  };

  programs.git = {
    enable = true;
    userName = "Zoroark";
    userEmail = "utybodev" + (builtins.elemAt [ "@" ] 0) + "gmail.com";
    extraConfig = {
      credential = {
        credentialStore = "secretservice";
        helper = "/nix/store/0dgisvxrsm2rjrv97yzl6zq92v5a41wi-git-credential-manager-2.0.785/bin/git-credential-manager-core";
      };
    };
  };
}
