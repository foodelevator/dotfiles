{ config, pkgs, ... }:
{
  xdg.dataFile."cargo/config.toml".source = ./cargo-config.toml;

  home.sessionVariables = {
    CARGO_HOME = "$HOME/.local/share/cargo";
    RUSTUP_HOME = "$HOME/.local/share/rustup";
  };

  home.packages = with pkgs; [
    rustup
  ];
}
