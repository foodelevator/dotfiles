{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.sets.ctf;

  shellInit = pkgs.writeText "fish-init" config.programs.fish.shellInit;

  ctf-env = pkgs.buildFHSEnv {
    name = "hack";
    runScript = "fish -C 'set hacking 1 && source ${shellInit}'";
    targetPkgs = pkgs: with pkgs; [
      binwalk
      exiftool
      wireshark

      nmap
      gobuster

      hashcat

      (python3.withPackages (p: with p; [
        pwntools
        tqdm
        z3
        requests
        pycryptodome
      ]))
      (symlinkJoin {
        name = "pwndbg-aliased";
        paths = [ pwndbg ];
        postBuild = ''
          ln -s $out/bin/pwndbg $out/bin/gdb
        '';
      })
      gdb
    ];
  };
in
{
  options.elevate.sets.ctf = {
    enable = mkEnableOption "engage hacker mode";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ghidra binary-ninja
      ctf-env
    ];
  };
}
