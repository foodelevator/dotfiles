{ config, pkgs, ... }:
let
  GOPATH = "$HOME/.local/share/go";
in
{
  imports = [
    ../../programs/git
    ../../programs/rustup
    ../../programs/node
    ../../programs/encore
    ../../programs/python

    ../../programs/discord
    ../../programs/alacritty
    ../../u2f/home.nix

    ../../programs/nix
    ../../programs/fish
    # ../../programs/gdb
    ../../programs/lf
    ../../programs/nvim
    ../../programs/helix
  ];

  home.sessionPath = [
    "${GOPATH}/bin"
  ];

  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";

    inherit GOPATH;
  };

  home.homeDirectory = "/home/mathias";
  home.username = "mathias";
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    feh
    xclip
    killall
    file
    lazygit
    mullvad
    jq
    distrobox
    ffmpeg
    unzip
    pgcli
    gnumake
    htop

    zig
    go
    gcc
    jdk
    swiProlog
    ghc
    gnumake

    java-language-server
    gopls
    rnix-lsp
    haskell-language-server

    ghidra
    # TODO: is broken: binary-ninja

    firefox
    ungoogled-chromium
    slack
    spotify
    obsidian
    zoom-us
    obs-studio
    logisim-evolution
    qFlipper
    gimp
  ];
}
