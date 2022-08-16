inputs @ {
  config,
  pkgs,
  ...
}: {
  imports = config.lib.signal.fs.listFiles ./systemd;
  config = {
    systemd.user.systemctlPath = if config.system.isNixOS then "/usr/bin/systemctl" else "${pkgs.systemd}/bin/systemctl";
    systemd.user.startServices = "sd-switch";
  };
}
