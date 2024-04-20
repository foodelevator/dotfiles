{ pkgs, ... }:
let
  kitty = pkgs.runCommand "kitty" {
    buildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir -p $out/bin
    makeWrapper ${pkgs.kitty}/bin/kitty $out/bin/kitty \
      --add-flags "-c ${./config}/kitty.conf"
  '';
in
{
  environment.systemPackages = [ kitty ];
}
