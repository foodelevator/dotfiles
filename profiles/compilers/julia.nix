{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ julia-bin ];

  environment.variables = {
    JULIA_DEPOT_PATH = [ "$HOME/.local/share/julia" ];
  };
}
