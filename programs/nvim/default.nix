{ config, pkgs, ... }:
{
  xdg.configFile."nvim".source = ./.;
  xdg.configFile."fourmolu.yaml".source = ./fourmolu.yaml;
}
