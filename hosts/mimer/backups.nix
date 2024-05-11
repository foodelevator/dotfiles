{ ... }:
{
  services.restic.backups."nvme" = {
    initialize = true;
    paths = [ "/media/nvme" ];
    repository = "sftp:u405230@u405230.your-storagebox.de:/mimir";
    passwordFile = "/home/mathias/.local/share/restic-password/password";
    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 5"
      "--keep-monthly 12"
    ];
  };
}
