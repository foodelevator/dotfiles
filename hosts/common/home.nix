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
    ../../programs/dunst
    ../../programs/i3
    ../../programs/alacritty

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
    scrot
    killall
    file
    lazygit
    mullvad
    jq
    distrobox
    ffmpeg
    mpv
    unzip
    pgcli
    gnumake

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

    ghidra
    # TODO: is broken: binary-ninja

    firefox
    ungoogled-chromium
    slack
    spotify
    pavucontrol
    obsidian
    zoom-us
    obs-studio
    logisim-evolution
    qFlipper
    gimp
  ];
}
