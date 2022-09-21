# Required tweaks for HiDPI shenanigans

{ config, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1"; # https://github.com/NixOS/nixpkgs/commit/b2eb5f62a7fd94ab58acafec9f64e54f97c508a6
}
