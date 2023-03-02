{ config, pkgs, ... }:
let
  hx = pkgs.writeShellScriptBin "hx" ''
    ${pkgs.helix}/bin/hx -c ${./config.toml} $@
  '';
in
{
  environment.systemPackages = [ hx ];
}
