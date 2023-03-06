{
  description = "Configuration for my NixOS systems";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;

    mixpkgs.url = github:mathiasmagnusson/mixpkgs;
  };

  outputs = { self, nixpkgs, mixpkgs } @ inputs:
    let
      lib = import ./lib.nix { inherit pkgs; };

      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (self: super: {
            binary-ninja = mixpkgs.packages.${system}.binary-ninja;
          })
        ];
      };
      mkSystem = name: nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [
          { _module.args = { inherit inputs; }; }
          (./hosts + "/${name}/configuration.nix")
        ] ++ lib.modules;
      };
    in
    {
      nixosConfigurations = builtins.mapAttrs
        (name: _: mkSystem name)
        (builtins.readDir ./hosts);
    };
}
