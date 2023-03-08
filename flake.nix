{
  description = "Configuration for my NixOS systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    mixpkgs.url = "github:mathiasmagnusson/mixpkgs";
    fakturamaskinen.url = "git+ssh://git@github.com/mathiasmagnusson/fakturamaskinen.git";
  };

  outputs = { self, nixpkgs, mixpkgs, fakturamaskinen } @ inputs:
    let
      lib = import ./lib.nix { inherit pkgs inputs; };

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
    in
    {
      nixosConfigurations = builtins.mapAttrs
        (name: _: nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = lib.getModules name;
        })
        (builtins.readDir ./hosts);
    };
}
