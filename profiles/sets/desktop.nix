{ pkgs, profiles, ... }:
{
  imports = with profiles; [
    system.fonts
    apps.kitty
  ];

  environment.systemPackages = with pkgs; [
    firefox
    ungoogled-chromium

    spotify
    slack
    mattermost-desktop
    signal-desktop
    zoom-us
    obsidian
    gimp
    audacity
    (discord.override { nss = nss_latest; }) # override needed to open links

    mpv
    feh
    xclip
    xorg.xhost
  ];

  programs.evince.enable = true;
  programs.nix-ld.enable = true;


  elevate.services.tldcheck = {
    enable = true;
    tlds = [ "on" "son" "sson" ];
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "altgr-intl";
    xkbOptions = "caps:escape";

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
      touchpad = {
        naturalScrolling = true;
        clickMethod = "clickfinger";
      };
    };

    excludePackages = [ pkgs.xterm ]; # 'tis ugly af
  };
}
