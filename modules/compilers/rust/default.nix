{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.compilers.rust;
in
{
  options.elevate.compilers.rust = {
    enable = mkEnableOption "configured rustup";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ rustup ];

    environment.variables = {
      CARGO_HOME = "$HOME/.local/share/cargo";
      CARGO_TARGET_DIR = "$HOME/.cache/target";
      RUSTUP_HOME = "$HOME/.local/share/rustup";
    };
  };
}
