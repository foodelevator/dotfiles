{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.cli-apps.git;
in
{
  options.elevate.cli-apps.git = {
    enable = mkEnableOption "git gud with this config";
  };

  config = mkIf cfg.enable {
    programs.git.enable = true;
    programs.git.config = {
      user.name = "Mathias Magnusson";
      user.email = "mathias@magnusson.space";

      alias = {
        st = "status";
        c = "commit";
        a = "add";
        p = "push";
        co = "checkout";
        br = "branch";
        sw = "switch";
      };

      init.defaultBranch = "main";

      pull.rebase = true;
    };
  };
}
