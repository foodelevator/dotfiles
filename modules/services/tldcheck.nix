{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.services.tldcheck;
in
{
  options.elevate.services.tldcheck = {
    enable = mkEnableOption "check for new tlds";
    tlds = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "The tlds that should be checked for";
    };
  };

  config = mkIf cfg.enable {
    systemd.timers.tldcheck = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "1h";
        Unit = "tldcheck.service";
      };
    };
    systemd.services.tldcheck = {
      path = with pkgs; [ gawk curl ];
      script = ''
        set -eu

        result=$(curl "https://data.iana.org/TLD/tlds-alpha-by-domain.txt" -s | awk 'tolower($0)~/${builtins.concatStringsSep "|" (map (t: "^${t}$") cfg.tlds)}/{print "TLD:n ."$0" finns!!!"}')
        if [[ -n "$result" ]]; then
            echo "$result" > ~/.cache/tldmsg
        fi
      '';
      serviceConfig = {
        Type = "oneshot";
        User = config.elevate.user.name;
      };
    };
  };
}
