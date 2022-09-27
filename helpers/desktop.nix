{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  ms-edge-wayland = import ../apps/ms-edge-wayland.nix { inherit config pkgs; };
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
    (
      let
        pnpmN16 = (unstable.nodePackages.override { nodejs = unstable.nodejs-16_x; }).pnpm;
      in
      pnpmN16.override {
        # Recent versions of nodeJS cause havoc with node2nix, leading to missing bins:
        # - https://github.com/svanderburg/node2nix/issues/293
        # - https://github.com/NixOS/nixpkgs/issues/145432
        # This recreates them manually
        postInstall = ''
          mkdir -p $out/bin
          for binary in $out/lib/node_modules/pnpm/bin/*.cjs; do
            ln -s $binary $out/bin/$(basename ''${binary%.cjs})
          done
          ${pnpmN16.postInstall}
        '';
      }
    )

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
  };
}
