{ config, pkgs, ... }:
let
  alacritty = pkgs.writeShellScriptBin "alacritty" ''
    ${pkgs.alacritty}/bin/alacritty --config-file ${./alacritty.yml} $@
  '';
in
{
  environment.systemPackages = [ alacritty ];
}
