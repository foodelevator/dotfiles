{ config, pkgs, ... }:
{
  programs.git.enable = true;
  programs.git.config = {
    user.name = "mathiasmagnusson";
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

    pull.rebase = false;
  };
}
