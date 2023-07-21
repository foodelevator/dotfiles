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
    homeDirs = mkEnableOption "sync home directories";
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
        pixel.id = "BZ7Q34Y-TXCKZQR-IB775RW-PZVB6I2-R22BWY3-EWZ4JKT-UFIWMXC-2Y3KIAS";
        space.id = "L4Q2WEZ-BGZSB3W-L4NZ22I-PP4T4AT-II6H6EB-N2YNW24-LNOGG6M-XUOLCAE";
        space.addresses = [ "tcp://magnusson.space" "tcp://139.162.175.166" ];
      };

      folders = lib.optionalAttrs cfg.homeDirs (pkgs.lib.genAttrs [
        "Desktop"
        "Documents"
        "Memes"
        "Music"
        "Videos"
        "Pictures"
      ] (name: {
        path = "${homeDir}/${name}";
        devices = ["chonk" "taplop"];
      })) // {
        Passage = {
          devices = ["chonk" "taplop" "space"];
          path = "${homeDir}/.local/share/passage/store";
        };
      };
    };
  };
}
