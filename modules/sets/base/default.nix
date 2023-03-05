{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.sets.base;
in
{
  options.elevate.sets.base = {
    enable = mkEnableOption "programs and configurations always wanted";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neovim /* dependencies for some plugins: */ tree-sitter ripgrep fd

      xclip killall file jq unzip xxd
    ];

    environment.variables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
    };

    elevate.cli-apps.fish.enable = true;
    elevate.cli-apps.git.enable = true;
    elevate.cli-apps.ssh.enable = true;
    elevate.system.env.enable = true;
    elevate.system.locale.enable = true;
    elevate.system.nix.enable = true;

    elevate.user = {
      enable = true;
      name = "mathias";
      email = "mathias@magnusson.space";
      description = "Mathias";
    };
  };
}
