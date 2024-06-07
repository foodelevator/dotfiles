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
    package = pkgs.postgresql_16;
    enableJIT = true;
    ensureUsers = [{
      inherit (config.elevate.user) name;
      ensureClauses.superuser = true;
      ensureClauses.login = true;
    }];
    authentication = ''
      local all postgres peer
      local all all      peer map=any
    '';
    identMap = ''
      any ${config.elevate.user.name} all
    '';
  };
}
