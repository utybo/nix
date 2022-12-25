{ config, pkgs, ... }:

let
  utybonur = (import ./utybonur.nix { inherit pkgs; });
in
{
  programs.git = {
    enable = true;
    userName = "Zoroark";
    userEmail = "utybodev" + (builtins.elemAt [ "@" ] 0) + "gmail.com";
    extraConfig = {
      credential = {
        credentialStore = "secretservice";
        helper = "${utybonur.git-credential-manager}/bin/git-credential-manager-core";
        "https://gitlab.cri.epita.fr" = {
        	gitlabDevClientId = "431687a5caddf104be11b50714cc29bb0a9f32cbe7c2b0d8f0e115f6ed3de7b8";
        	gitlabDevClientSecret = "2531b14e2c43525c7d78de5a71780357bb394f655005c2d8c88151591011da32";
        };
      };
    };
  };
}
