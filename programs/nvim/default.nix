{ config, pkgs, ... }:
{
  xdg.configFile."nvim".source = ./.;
  xdg.configFile."fourmolu.yaml".source = ./fourmolu.yaml;

  home.packages = with pkgs; [
    tree-sitter
    ripgrep
    fd
  ];
}
