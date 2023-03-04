{ config, pkgs, ... }:
let
  alacritty = pkgs.runCommand "alacritty" {
    buildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir $out
    ln -s ${pkgs.alacritty}/* $out
    rm $out/bin
    mkdir $out/bin
    ln -s ${pkgs.alacritty}/bin/* $out/bin
    rm $out/bin/alacritty

    makeWrapper ${pkgs.alacritty}/bin/alacritty $out/bin/alacritty \
      --add-flags "--config-file ${./alacritty.yml}" \
      --argv0 ${pkgs.alacritty}/bin/alacritty
    # When using SpawnNewInstance, alacritty uses $0 to find itself and appends the same
    # flags to the new instance. If $0 is "alacritty", the config flag is duplicated since it is
    # added here too, and that makes alacritty fail to start.
  '';
in
{
  environment.systemPackages = [ alacritty ];
}
