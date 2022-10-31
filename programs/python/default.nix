{ config, pkgs, ... }:
let
  python-packages = p: with p; [
    pycryptodome
    numpy
    matplotlib
    scipy
  ];
in
{
  home.packages = with pkgs; [
    (python3.withPackages python-packages)
  ];
}
