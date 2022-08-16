{ config, pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    user = "mathias";
    dataDir = "/home/mathias";
    configDir = "/home/mathias/.config/syncthing";

    devices = {
      chonk.id = "N6CY7HR-KBEBJY5-ZMS3U2B-TMJY4H7-MVW47VN-UK3YMWT-GLWR7PR-NJT5PQI";
      taplop.id = "JOOVGP7-BNR6OTA-H5W53FT-EUY6O3T-KZSP5MT-EFZR7QL-WOZA6RT-ANKZOQ3";
    };

    folders = {
      "Documents" = {
        path = "/home/mathias/Documents";
        devices = ["chonk" "taplop"];
      };
    };
  };
}
