{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ../helpers/arduino.nix
    ../helpers/c.nix
    ../helpers/dotnet.nix
    ../helpers/java.nix
    ../helpers/js.nix
    ../helpers/nixtools.nix
    ../helpers/python.nix
    ../helpers/vscode.nix
  ];
}
