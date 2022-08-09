{ config, pkgs, ... }:
let
  GOPATH = "$HOME/.local/share/go";
in
{
  imports = [
    ../../programs/git
    ../../programs/rustup
    ../../programs/node

    ../../programs/dunst
    ../../programs/i3
    ../../programs/kitty

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
    alacritty
    kitty
    feh
    lf
    xclip

    tree-sitter
    ripgrep
    fd

    zig
    go

    dunst
    i3blocks

    firefox
    (discord.override { nss = nss_latest; }) # needed to open links
    slack
    spotify
    pavucontrol
    slack
  ];
}
