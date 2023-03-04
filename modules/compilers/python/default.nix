{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.compilers.python;

  python = (pkgs.python3.withPackages (p: with p; [
    pycryptodome
    numpy
    matplotlib
    gmpy2
  ]));
in
{
  options.elevate.compilers.python = {
    enable = mkEnableOption "configured python interpreter with some packages";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      PYTHONSTARTUP = pkgs.writeText "pythonstartup.py" (builtins.readFile ./pythonstartup.py);
    };

    environment.systemPackages = [ python ];
  };
}
