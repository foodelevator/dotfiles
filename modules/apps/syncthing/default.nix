{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.apps.syncthing;

  user = config.elevate.user.name;
  homeDir = "/home/${user}";
in
{
  options.elevate.apps.syncthing = {
    enable = mkEnableOption "configured syncthing";
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      inherit user;
      dataDir = homeDir;
      configDir = "${homeDir}/.config/syncthing";

      devices = {
        chonk.id = "N6CY7HR-KBEBJY5-ZMS3U2B-TMJY4H7-MVW47VN-UK3YMWT-GLWR7PR-NJT5PQI";
        taplop.id = "JOOVGP7-BNR6OTA-H5W53FT-EUY6O3T-KZSP5MT-EFZR7QL-WOZA6RT-ANKZOQ3";
      };

      folders = pkgs.lib.genAttrs [
        "Desktop"
        "Documents"
        "Memes"
        "Music"
        "Videos"
        "Pictures"
      ] (name: {
        path = "/${homeDir}/${name}";
        devices = ["chonk" "taplop"];
      });
    };
  };
}
