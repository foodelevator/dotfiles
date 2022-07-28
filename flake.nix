# Resources
# https://www.youtube.com/watch?v=AGVXJ-TIv3Y
# https://serokell.io/blog/practical-nix-flakes
# To look into:
# nixos-rebuild build-vm

{
  description = "System config";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      pingupc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
    };
  };
}
