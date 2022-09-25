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

    ../../programs/discord
    ../../programs/dunst
    ../../programs/i3
    ../../programs/alacritty

    ../../programs/nix
    ../../programs/fish
    # ../../programs/gdb
    ../../programs/lf
    ../../programs/nvim
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

    zig
    go
    gcc
    python3
    jdk
    swiProlog

    java-language-server
    gopls
    rnix-lsp

    ghidra

    firefox
    ungoogled-chromium
    slack
    spotify
    pavucontrol
    obsidian
    zoom-us
    obs-studio
  ];
}
