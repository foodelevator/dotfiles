{ pkgs, ... }:
let
  GOPATH = "$HOME/.local/share/go";
in
{
  environment.systemPackages = with pkgs; [ go /* gopls (doesn't currently work with go 1.22.0; installed with `go install` instead) */ ];

  environment.variables = {
    inherit GOPATH;
    PATH = [ "${GOPATH}/bin" ];
  };
}
