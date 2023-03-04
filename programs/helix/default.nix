{ config, pkgs, ... }:
let
  hx = pkgs.runCommand "helix" {
    buildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir $out
    ln -s ${pkgs.helix}/* $out
    rm $out/bin
    mkdir $out/bin
    ln -s ${pkgs.helix}/bin/* $out/bin
    rm $out/bin/hx

    makeWrapper ${pkgs.helix}/bin/hx $out/bin/hx --add-flags "-c ${./config.toml}"
  '';
in
{
  environment.systemPackages = [ hx ];
}
