{
  description = "Configuration for my NixOS systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-22.11";

    fakturamaskinen.url = "git+ssh://git@github.com/mathiasmagnusson/fakturamaskinen.git";
    fakturamaskinen.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, stable, fakturamaskinen, deploy-rs } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (self: super: {
            binary-ninja = stable.legacyPackages.${system}.callPackage
              ./packages/binary-ninja
              { };
            inherit (deploy-rs.packages.${system}) deploy-rs;
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
