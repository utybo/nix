{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  imports = [
    ./hidpi.nix
    ./shell.nix
  ];

  home.packages = [
    pkgs.micro
    unstable.discord
    pkgs.gnome.gnome-tweaks
    pkgs.slack
    pkgs.gh
    pkgs.jdk
    pkgs.jdk17
    pkgs.maven
    pkgs.wl-clipboard
    unstable.jetbrains.idea-ultimate
    (
      let
        microsoft-edge-no-desktop = pkgs.microsoft-edge.overrideAttrs (oldAttrs: rec {
          fixupPhase = ''
            mv $out/share/applications/microsoft-edge.desktop $out/share/applications/microsoft-edge.desktop.disabled

            substituteInPlace $out/bin/microsoft-edge \
              --replace /bin/bash ${pkgs.bash}/bin/bash
          '';
        });
      in pkgs.symlinkJoin {
        name = "zoroedge";
        paths = [ microsoft-edge-no-desktop ];
        buildInputs = [ microsoft-edge-no-desktop pkgs.makeWrapper pkgs.wayland ];
        postBuild = ''
          cp ${microsoft-edge-no-desktop}/share/applications/microsoft-edge.desktop.disabled \
            $out/share/applications/microsoft-edge.desktop
          
          substituteInPlace $out/share/applications/microsoft-edge.desktop \
            --replace ${microsoft-edge-no-desktop}/bin/microsoft-edge $out/bin/microsoft-edge
          
          wrapProgram $out/bin/microsoft-edge \
            --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland" \
            --set LD_LIBRARY_PATH ${pkgs.wayland}/lib
        '';
    })
    pkgs.cascadia-code
    pkgs.jbang
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

  # Flag for Wayland support with MS edge


  programs.git = {
    enable = true;
    userName = "Zoroark";
    userEmail = "utybodev" + (builtins.elemAt [ "@" ] 0 ) + "gmail.com";
  };
}
