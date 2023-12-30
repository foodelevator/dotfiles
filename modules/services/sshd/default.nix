{ config, lib, ... }:
with lib;
let
  cfg = config.elevate.services.sshd;
in
{
  options.elevate.services.sshd = {
    enable = mkEnableOption "configured ssh daemon";
  };

  config = mkIf cfg.enable {
    elevate.user.sshKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPC69ml72mqbn7L3QkpsCJuWdrKFYFNd0MaS5xERbuSF mathias@pingu-arch"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAO88bhtrgWXg4zY8jIAVqzyHKa+PNJRpLbyk86y4Glc mathias@taplop"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEdUe7mxGdV/Q37RKndPzDHisFb7q/xm+L97jcGluSDOA8MGt/+wTxpyGxfyEqaMvwV2bakaMVHTB3711dDu5kE= 5nfc"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBLZ6OVyjTvWx9gvS+/DvkQW5VvLBbykq/0AV5mYDLADDtIOaDVscQ3lGOcUsga1ODNSl14MSV63bE8VtHfG1HOc= 5nano"
    ];
    services.openssh = {
      enable = true;
      listenAddresses = [{ addr = "0.0.0.0"; port = 69; }];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}
