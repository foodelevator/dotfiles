{ config, pkgs, ... }:
let
  GOPATH = "$HOME/.local/share/go";
in
{
  imports = [
    ../../programs/cargo
    ../../programs/git

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
    CARGO_HOME = "$HOME/.local/share/cargo";
    RUSTUP_HOME = "$HOME/.local/share/rustup";

    XCOMPOSECACHE = "$HOME/.cache/compose-cache";
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
    rustup
    go

    dunst
    i3blocks

    firefox
    (discord.override { nss = nss_latest; }) # needed to open links
    spotify
    pavucontrol
  ];
}
