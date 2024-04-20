{
  description = "Configuration for my NixOS systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, unstable } @ inputs:
    let
      system = "x86_64-linux";

      unstablePkgs = import unstable { inherit system; config.allowUnfree = true; };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = ["electron-25.9.0"]; # for obsidian
        overlays = [
          (final: prev: {
            inherit (unstablePkgs) zig zoom-us r2modman podman go_1_22;
            nomad = unstablePkgs.nomad_1_6;

            binary-ninja = prev.callPackage ./packages/binary-ninja { };
            dyalog = prev.callPackage ./packages/dyalog { };
          })
        ];
      };

      lib = import ./lib.nix { inherit (nixpkgs) lib; inherit inputs; };
    in
    {
      nixosConfigurations = builtins.mapAttrs
        (name: _: nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = lib.getModules name;
        })
        (builtins.readDir ./hosts);

      packages.${system} = {
        inherit (pkgs) binary-ninja dyalog;
      };
    };
}
