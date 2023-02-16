{ pkgs, config, ... }:
{
  # services.udev.packages = [ pkgs.yubikey-personalization ];

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  environment.systemPackages = with pkgs; [
    pam_u2f
  ];

  services.pcscd.enable = true;

  users.users.mathias.packages = with pkgs; [
    yubioath-flutter
  ];
}
