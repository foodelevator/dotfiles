{ pkgs, profiles, ... }:
{
  imports = with profiles; [
    apps.steam
  ];

  environment.systemPackages = with pkgs; [ prismlauncher r2modman ];
}
