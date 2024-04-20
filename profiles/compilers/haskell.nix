{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ ghc haskell-language-server ];

  environment.variables = {
    CABAL_DIR = "$HOME/.local/share/cabal";
  };
}
