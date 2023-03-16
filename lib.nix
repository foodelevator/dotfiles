{ pkgs, inputs }:
let
  inherit (builtins) concatLists readDir;
  inherit (pkgs.lib) mapAttrsToList;

  getAllDefaultDotNix = path:
    let
      dir = readDir path;
      traverse = name: type:
        if name == "default.nix" then
          [ "${path}/${name}" ]
        else if type == "directory" then
          getAllDefaultDotNix "${path}/${name}"
        else [ ];
    in
    concatLists (mapAttrsToList traverse dir);

  # TODO: It would be nice to extend `lib` instead
  helpers = { };
in
{
  getModules = name: [
    (./hosts + "/${name}/configuration.nix")
    (./hosts + "/${name}/hardware-configuration.nix")
    { _module.args = { inherit inputs helpers; }; }
    ({ lib, ... }: { networking.hostName = lib.mkDefault name; })
  ] ++ getAllDefaultDotNix ./modules;
}
