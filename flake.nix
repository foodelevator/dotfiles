{
  description = "Configuration for my NixOS systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, unstable, deploy-rs } @ inputs:
    let
      system = "x86_64-linux";

      unstablePkgs = import unstable { inherit system; };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            inherit (deploy-rs.packages.${system}) deploy-rs;
            inherit (unstablePkgs) yubioath-flutter typst typst-lsp;

            binary-ninja = prev.callPackage ./packages/binary-ninja { };
            dyalog = prev.callPackage ./packages/dyalog { };
          })
        ];
      };

      lib = import ./lib.nix { inherit pkgs inputs; };
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

      deploy.nodes = builtins.mapAttrs
        (hostname: cfg: {
          inherit hostname;
          profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos cfg;
          profiles.system.user = "root";
        })
        (pkgs.lib.filterAttrs
          (_: { config, ... }: config.elevate.archetypes.server.enable)
          self.nixosConfigurations);

      checks = builtins.mapAttrs
        (_: deployLib: deployLib.deployChecks self.deploy)
        deploy-rs.lib;
    };
}
