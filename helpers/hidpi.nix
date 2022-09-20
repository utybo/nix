# Required tweaks for HiDPI shenanigans

# Add the following to your /etc/nixos/configuration.nix

#  # Enable fractional scaling things
#  services.xserver.desktopManager.gnome = {
#    # see https://github.com/NixOS/nixpkgs/issues/114514#issuecomment-1158715877
#    extraGSettingsOverridePackages = [pkgs.gnome.mutter];
#    extraGSettingsOverrides = ''
#      [org.gnome.mutter]
#      experimental-features=['scale-monitor-framebuffer']
#    '';
#  };

{ config, pkgs, ... }:

{
  home.sessionVariables.NIXOS_OZONE_WL = "1"; # https://github.com/NixOS/nixpkgs/commit/b2eb5f62a7fd94ab58acafec9f64e54f97c508a6
}
