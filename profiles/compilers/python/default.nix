{ pkgs, ... }:
let
  # is it possible to not add these packageses scripts to PATH?
  python = (pkgs.python3.withPackages (p: with p; [
    virtualenv
    pycryptodome
    numpy
    matplotlib
    gmpy2
    requests
  ]));
in
{
  environment.variables = {
    PYTHONSTARTUP = pkgs.writeText "pythonstartup.py" (builtins.readFile ./pythonstartup.py);
  };

  environment.systemPackages = [ python ];
}
