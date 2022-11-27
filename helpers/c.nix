{ config, pkgs, ... }:
{
  home.packages = [
    # GCC and Clang have a conflict with `ld`, set gcc as higher priority to resolve it
    (pkgs.hiPrio pkgs.gcc)
    pkgs.clang
    pkgs.gnumake
    pkgs.clang-tools
    pkgs.criterion
    pkgs.criterion.dev
  ];
}
