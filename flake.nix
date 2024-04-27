{
  description = "Configuration for my NixOS systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default-linux"; # {aarch64,x86_64}-linux

    nh.url = "github:viperML/nh/fe4a96a0b0b0662dba7c186b4a1746c70bbcad03";
    nh.inputs.nixpkgs.follows = "nixpkgs";

    nix-rpi5.url = "gitlab:vriska/nix-rpi5";
    nix-rpi5.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, systems, nixpkgs, unstable, ... } @ inputs:
    let
      mapSystems = f: builtins.mapAttrs (system: _: f system) (nixpkgs.lib.genAttrs (import systems) (_: null));

      pkgs = mapSystems (system:
        let
          unstablePkgs = import unstable { inherit system; config.allowUnfree = true; };
        in
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.permittedInsecurePackages = [ "electron-25.9.0" ]; # for obsidian
          overlays = [
            (final: prev: {
              inherit (unstablePkgs) zig zoom-us r2modman podman go_1_22 nomad_1_6;

              binary-ninja = prev.callPackage ./packages/binary-ninja { };
            } // (if system == "aarch64-linux" then {
              makeModulesClosure = x: prev.makeModulesClosure (x // { allowMissing = true; });
              inherit (inputs.nix-rpi5.legacyPackages.aarch64-linux) linuxPackages_rpi5;
            } else { }))
          ];
        }
      );

      lib = import ./lib.nix { inherit (nixpkgs) lib; };
    in
    {
      nixosConfigurations = builtins.mapAttrs
        (name: _:
          let
            config = import (./hosts + "/${name}/configuration.nix");
            system = (config (builtins.functionArgs config)).nixpkgs.hostPlatform;
          in
          nixpkgs.lib.nixosSystem
            {
              inherit system;
              pkgs = pkgs.${system};
              specialArgs = {
                inherit inputs;
                profiles = lib.rakeLeaves ./profiles;
              };
              modules = [
                (./hosts + "/${name}/configuration.nix")
                (./hosts + "/${name}/hardware-configuration.nix")
                ({ ... }: { networking.hostName = name; })
              ] ++ (nixpkgs.lib.collect builtins.isPath (lib.rakeLeaves ./modules));
            })
        (builtins.readDir ./hosts);

      formatter = mapSystems (system: pkgs.${system}.nixpkgs-fmt);
    };
}
