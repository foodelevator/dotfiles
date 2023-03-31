{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.system.env;
in
{
  options.elevate.system.env = {
    enable = mkEnableOption "setup some environment variables";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      XCOMPOSECACHE = "$HOME/.cache/compose-cache";
      # XAUTHORITY = "$HOME/.local/state/Xauthority";
      GNUPG_HOME = "$HOME/.local/share/gnupg";
    };
    environment.defaultPackages = with pkgs; [ rsync strace ]; # nano & perl removed
  };
}
