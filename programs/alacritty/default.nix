{ config, pkgs, ... }:
let
  alacritty = pkgs.runCommand "alacritty" {} ''
    . ${pkgs.makeWrapper}/nix-support/setup-hook

    cp -r ${pkgs.alacritty} $out
    chown -R $(id -u -n):$(id -g -n) $out
    chmod -R u+w $out

    wrapProgram $out/bin/alacritty --add-flags "--config-file ${./alacritty.yml}"
  '';
in
{
  environment.systemPackages = [ alacritty ];
}
