{ config, pkgs, ... }:
let
  python-packages = p: with p; [
    pycryptodome
    numpy
    matplotlib
    scipy
    gmpy2
    jupyter
  ];
in
{
  home.packages = with pkgs; [
    (python3.withPackages python-packages)
  ];
}
