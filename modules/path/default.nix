{ config, lib, ... }:
with lib;
let
  cfg = config.elevate.path;
in
{
  options.elevate.path = mkOption {
    type = types.listOf types.str;
    default = [];
    description = mdDoc "Entries to be added to the `$PATH` environment variable.";
  };

  config.environment.variables.PATH = concatStringsSep ":" cfg + ":$PATH";
}
