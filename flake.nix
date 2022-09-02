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

    devShells.${system}.ctf =
    let
      pwn-python = pkgs.python3.withPackages (p: [
        p.pwntools
      ]);
    in
    pkgs.mkShell {
      buildInputs = [
        pkgs.fish
        pkgs.gdb
        pkgs.ghidra
        pkgs.steam-run
        pwn-python
        self.packages.${system}.binary-ninja-demo
      ];
      shellHook = ''
        PYTHONPATH=${pwn-python}/${pwn-python.sitePackages}
        exec fish
        alias ida='LD_PRELOAD=/nix/store/0m2yih08321iwv5a9yxykgjq8yzwpzd5-xcb-util-wm-0.4.1/lib/libxcb-icccm.so.4:/nix/store/0ij693svsi5bjai490iphwyca9hbch1n-xcb-util-image-0.4.0/lib/libxcb-image.so.0:/nix/store/7sv0qkyz6rc66g85jk54jv7mf17q455f-xcb-util-keysyms-0.4.0/lib/libxcb-keysyms.so.1:/nix/store/2gnvqqzjl629ydi8m50i2i7j06vn5mda-xcb-util-renderutil-0.3.9/lib/libxcb-render-util.so.0 steam-run ./.local/share/idafree-8.0/ida64'
      '';
    };

    packages.${system}.binary-ninja-demo = import ./programs/binary-ninja { inherit pkgs; };
  };
}
