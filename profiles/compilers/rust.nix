{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ rustup ];

  environment.variables = {
    CARGO_HOME = "$HOME/.local/share/cargo";
    CARGO_TARGET_DIR = "$HOME/.cache/target";
    RUSTUP_HOME = "$HOME/.local/share/rustup";
  };
}
