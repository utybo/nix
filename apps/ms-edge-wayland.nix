{ config, pkgs, ... }:

# Microsoft Edge for Wayland

let
  # Original package with the desktop file disabled (the desktop file refers to the incorrectly launched binary)
  microsoft-edge-no-desktop = pkgs.microsoft-edge.overrideAttrs (oldAttrs: rec {
    fixupPhase = ''
      mv $out/share/applications/microsoft-edge.desktop \
        $out/share/applications/microsoft-edge.desktop.disabled

      substituteInPlace $out/bin/microsoft-edge \
        --replace /bin/bash ${pkgs.bash}/bin/bash
    '';
  });
in
pkgs.symlinkJoin {
  # This patch wraps the ms edge binary to launch it with the correct flags and patches the desktop file
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
}
    
