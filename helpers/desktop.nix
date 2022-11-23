{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  ms-edge-wayland = import ../apps/ms-edge-wayland.nix { inherit config pkgs; };
  node16Packages = (unstable.nodePackages.override { nodejs = unstable.nodejs-16_x; });
in
{
  imports = [
    ./hidpi.nix
    ./shell.nix
  ];

  home.packages = [
    # Small utilities
    pkgs.figlet
    pkgs.gh
    pkgs.gnome.gnome-tweaks
    pkgs.lolcat
    pkgs.micro
    pkgs.pavucontrol
    pkgs.wl-clipboard
    pkgs.bat

    # Nix-related utilities
    pkgs.nixpkgs-fmt
    pkgs.rnix-lsp

    # Java dev tools
    pkgs.jbang
    pkgs.jdk17
    pkgs.maven
    pkgs.bind
    unstable.gradle
    unstable.jetbrains.idea-ultimate

    # Node dev tools
    unstable.nodejs
    node16Packages.pnpm

    # .NET dev tools
    pkgs.dotnet-sdk
    unstable.jetbrains.rider

    # C dev tools
    # GCC and Clang have a conflict with `ld`, set gcc as higher priority to resolve it
    (pkgs.hiPrio pkgs.gcc)
    pkgs.clang
    pkgs.gnumake
    pkgs.clang-tools
    pkgs.criterion
    pkgs.criterion.dev

    # Python dev tools
    pkgs.python310
    unstable.python310Packages.poetry

    # Communication apps
    unstable.slack
    unstable.discord

    # Random apps
    pkgs.spotify
    pkgs.inkscape
    pkgs.libreoffice
    pkgs.yubikey-manager-qt
    pkgs.google-chrome
    unstable.newsflash
    unstable.etcher

    # Fonts
    pkgs.cascadia-code

    # Patched apps
    ms-edge-wayland

    # Man pages
    pkgs.man-pages
    pkgs.man-pages-posix

    # Arduino
    pkgs.arduino
  ];

  home.enableDebugInfo = true;
  home.enableNixpkgsReleaseCheck = true;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland.override {
      cfg = {
        enableGnomeExtensions = true;
      };
    };
  };


  programs.vscode = {
    enable = true;
    package = unstable.vscode;
    # package = unstable.vscode.fhsWithPackages (ps: with ps; [ 
    #   vscode-extensions.ms-vscode.cpptools
    #   git
    # ]);
    extensions = [ unstable.vscode-extensions.ms-vscode.cpptools ];
  };

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

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      filetype plugin indent on
      set tabstop=4
      set shiftwidth=4
      set expandtab
    '';
  };

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
