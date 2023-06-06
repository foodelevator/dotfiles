{ config, pkgs, lib, helpers, ... }:
with lib;
let
  cfg = config.elevate.websites.f;
in
{
  options.elevate.websites.f = {
    enable = mkEnableOption "Link";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."f.djul.se" = {
      forceSSL = true;
      enableACME = true;

      locations."/" = {
        return = "303 https://docs.google.com/forms/d/e/1FAIpQLScsZKLwLfWvZXscuie-2DicE76aQ1R4aNGGgJC5XETVB1miww/viewform?usp=sf_link";
      };
    };
  };
}
