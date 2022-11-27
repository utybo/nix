# Misc. CLI tools


{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.figlet
    pkgs.gh
    pkgs.lolcat
    pkgs.micro
    pkgs.wl-clipboard
    pkgs.bat
  ];
}
