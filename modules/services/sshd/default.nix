{ config, pkgs, lib, ... }:
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
    ];
    services.openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = false;
      ports = [ 69 ];
    };
  };
}