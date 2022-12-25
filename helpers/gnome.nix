{ config, pkgs, lib, ... }:

let
  unstable = (import ./unstable.nix);
  autostartPrograms = [ pkgs.discord unstable.slack ];
in
rec {
  imports = [
    ./fonts.nix
  ];

  home.activation = {
    defaultWebBrowser = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD xdg-settings set default-web-browser microsoft-edge.desktop
    '';
  };

  home.packages = [
    unstable.gnomeExtensions.appindicator
    unstable.gnomeExtensions.spotify-tray
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      monospace-font-name = "Cascadia Code 12";
    };
    # From https://github.com/nix-community/home-manager/issues/284#issuecomment-1321199263
    "org/gnome/shell" = {
      enabled-extensions = map (extension: extension.extensionUuid) home.packages;
    };
  };

  home.file = builtins.listToAttrs (map
    (pkg:
      {
        name = ".config/autostart/" + pkg.pname + ".desktop";
        value =
          if pkg ? desktopItem then {
            # Application has a desktopItem entry. 
            # Assume that it was made with makeDesktopEntry, which exposes a
            # text attribute with the contents of the .desktop file
            text = pkg.desktopItem.text;
          } else {
            # Application does *not* have a desktopItem entry. Try to find a
            # matching .desktop name in /share/apaplications
            source = (pkg + "/share/applications/" + pkg.pname + ".desktop");
          };
      })
    autostartPrograms);
}
