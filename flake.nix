# Resources
# https://www.youtube.com/watch?v=AGVXJ-TIv3Y
# https://serokell.io/blog/practical-nix-flakes
# https://nixos.org/guides/nix-pills/generic-builders.html
# To look into:
# nixos-rebuild build-vm

{
  description = "System config";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;

    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    mixpkgs.url = github:mathiasmagnusson/mixpkgs;
  };

  outputs = { self, nixpkgs, home-manager, mixpkgs }:
  let
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
    lib = import ./lib.nix { inherit pkgs; };
  in
  {
    nixosConfigurations = {
      chonk = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [ ./hosts/chonk/configuration.nix ] ++ lib.modules;
      };
      taplop = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [ ./hosts/taplop/configuration.nix ] ++ lib.modules;
      };
    };

    homeConfigurations = {
      chonk = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hosts/chonk/home.nix ];
      };
      taplop = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./hosts/taplop/home.nix ];
      };
    };
  };
}
