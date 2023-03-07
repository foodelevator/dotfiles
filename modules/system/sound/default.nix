{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.system.sound;
in
{
  options.elevate.system.sound = {
    enable = mkEnableOption "🔊🔊🔊";
  };

  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    hardware.pulseaudio.enable = false; # gnome sets this to `lib.mkDefault true`
  };
}
