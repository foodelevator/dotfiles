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
  };

  outputs = { self, nixpkgs, home-manager }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations = {
      chonk = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [ ./hosts/chonk/configuration.nix ];
      };
      taplop = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        modules = [ ./hosts/taplop/configuration.nix ];
      };
    };
    homeConfigurations.mathias = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [ ./home.nix ];
    };
  };
}
