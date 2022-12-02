{ config, pkgs, ... }:

let
  utybonur = (import ./utybonur.nix { inherit pkgs; }).utybonur;
in
{
  programs. git = {
    enable = true;
    userName = "Zoroark";
    userEmail = "utybodev" + (builtins.elemAt [ "@" ] 0) + "gmail.com";
    extraConfig = {
      credential = {
        credentialStore = "secretservice";
        helper = "${utybonur.git-credential-manager}/bin/git-credential-manager-core";
      };
    };
  };
}
