{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Zoroark";
    userEmail = "utybodev" + (builtins.elemAt [ "@" ] 0) + "gmail.com";
    extraConfig = {
      credential = {
        credentialStore = "secretservice";
        helper = "/nix/store/0dgisvxrsm2rjrv97yzl6zq92v5a41wi-git-credential-manager-2.0.785/bin/git-credential-manager-core";
      };
    };
  };
}
