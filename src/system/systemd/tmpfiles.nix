inputs @ {
  config,
  pkgs,
  utils,
  ...
}: {
  systemd.user.tmpfiles.rules = [
    "D %t/ssh 0700 - -"
  ];
}
