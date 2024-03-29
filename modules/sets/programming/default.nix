{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.sets.programming;
in
{
  options.elevate.sets.programming = {
    enable = mkEnableOption "programs for programming programs and ports for development";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lazygit
      ((pgcli.override { keyring = null; }).overrideAttrs { disabledTests = true; })
      entr

      zig
      gcc gnumake
      jdk
      nil nixpkgs-fmt
      lua-language-server
      dockerfile-language-server-nodejs docker-compose-language-service
    ];

    environment.variables = {
      LG_CONFIG_FILE = pkgs.writeText "lazygit.yaml" ''
        git:
          autoFetch: false
        customCommands:
          - key: '<c-p>'
            description: "Push to a specific remote repository"
            context: 'global'
            loadingText: 'Pushing ...'
            prompts:
              - type: 'menuFromCommand'
                title: 'Which remote repository to push to?'
                command: bash -c "git remote --verbose | grep '(push)$'"
                filter: '(?P<remote>[^\s]*)\s+(?P<url>[^\s]*) \(push\)'
                valueFormat: '{{ .remote }}'
                labelFormat: '{{ .remote | bold | cyan }} {{ .url }}'
              - type: 'menu'
                title: 'How to push?'
                options:
                  - value: 'push'
                  - value: 'push --force-with-lease'
                  - value: 'push --force'
            command: "git {{index .PromptResponses 1}} {{index .PromptResponses 0 | quote}}"
      '';
    };

    programs.direnv.enable = true;
    environment.etc."direnv/direnv.toml".text = ''
      [global]
      load_dotenv = true
      strict_env = true
    '';

    elevate.cli-apps.helix.enable = true;

    elevate.compilers = {
      encore.enable = true;
      go.enable = true;
      haskell.enable = true;
      julia.enable = true;
      node.enable = true;
      python.enable = true;
      rust.enable = true;
    };

    networking.firewall.allowedTCPPorts = [ 80 443 1337 3000 5000 8000 8080 ];
    networking.firewall.allowedUDPPorts = [ 1337 ];

    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_15;
      enableJIT = true;
      ensureUsers = [{
        inherit (config.elevate.user) name;
        ensureClauses.superuser = true;
        ensureClauses.login = true;
      }];
    };
  };
}
