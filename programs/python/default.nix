{ config, pkgs, ... }:
{
  environment.variables = {
    PYTHONSTARTUP = pkgs.writeText "pythonstartup.py" (builtins.readFile ./pythonstartup.py);
  };

  users.users.mathias.packages = with pkgs; [
    (python3.withPackages (p: with p; [
      pycryptodome
      numpy
      matplotlib
      scipy
      gmpy2
    ]))
  ];
}
