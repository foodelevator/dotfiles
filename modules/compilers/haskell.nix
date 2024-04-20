{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.compilers.haskell;
in
{
  options.elevate.compilers.haskell = {
    enable = mkEnableOption "configured haskell environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ghc haskell-language-server ];

    environment.variables = {
      CABAL_DIR = "$HOME/.local/share/cabal";
    };
  };
}
