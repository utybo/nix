{ config, pkgs, ... }:

{
  programs.bash.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    history = {
      ignoreSpace = true;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "github" "gradle" "mvn" "node" "npm" "python" "sudo" "direnv" ];
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
