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
in
{
  getModules = name: [
    (./hosts + "/${name}/configuration.nix")
    (./hosts + "/${name}/hardware-configuration.nix")
    { _module.args = { inherit inputs; }; }
    ({ lib, ... }: { networking.hostName = lib.mkDefault name; })
  ] ++ getAllDefaultDotNix ./modules;
}
