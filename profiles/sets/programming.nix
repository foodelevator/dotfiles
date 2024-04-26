{ config, pkgs, profiles, ... }:
{
  imports = with profiles; [
    compilers.go
    compilers.haskell
    compilers.julia
    compilers.node
    compilers.python
    compilers.rust

    cli-apps.helix
  ];

  environment.systemPackages = with pkgs; [
    lazygit
    ((pgcli.override { keyring = null; }).overrideAttrs { disabledTests = true; })
    entr

    zig
    gcc
    gnumake
    jdk
    nil
    nixpkgs-fmt
    lua-language-server
    dockerfile-language-server-nodejs
    docker-compose-language-service
    gdb
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

  environment.etc."gdb/gdbinit".text = ''
    set disassembly-flavor intel
    alias da = disassemble
    set detach-on-fork off
    set follow-fork-mode child
  '';

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
}
