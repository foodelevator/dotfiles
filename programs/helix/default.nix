{ config, pkgs, ... }:
let
  hx = pkgs.runCommand "helix" {} ''
    . ${pkgs.makeWrapper}/nix-support/setup-hook

    cp -r ${pkgs.helix} $out
    chown -R $(id -u -n):$(id -g -n) $out
    chmod -R u+w $out

    wrapProgram $out/bin/hx --add-flags "-c ${./config.toml}"
  '';
in
{
  environment.systemPackages = [ hx ];
}
