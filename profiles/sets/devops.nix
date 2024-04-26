{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    terraform-ls
    awscli2
    hcloud
    nomad_1_6
  ];

  environment.variables = {
    TF_CLI_CONFIG_FILE = pkgs.writeText "terraform.tfrc" ''
      disable_checkpoint = true
    '';
  };
}
