inputs @ {
  config,
  pkgs,
  lib,
  ...
}: {
  imports = lib.signal.fs.path.listFilePaths ./systemd;
  config = {
    systemd.user.systemctlPath =
      if config.system.isNixOS
      then "/usr/bin/systemctl"
      else "${pkgs.systemd}/bin/systemctl";
    systemd.user.startServices = "sd-switch";
  };
}
