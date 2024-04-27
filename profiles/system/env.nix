{ ... }:
{
  environment.variables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    XCOMPOSECACHE = "$HOME/.cache/compose-cache";
    # XAUTHORITY = "$HOME/.local/state/Xauthority";
    GNUPG_HOME = "$HOME/.local/share/gnupg";
  };
}
