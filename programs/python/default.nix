{ config, pkgs, ... }:
{
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
