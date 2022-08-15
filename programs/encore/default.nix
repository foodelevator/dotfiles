{ config, pkgs, ... }:
let
  install = "$HOME/.local/share/encore";
in
{
  home.sessionVariables = {
    ENCORE_INSTALL = install;
  };

  home.sessionPath = [
    "${install}/bin"
  ];
}
