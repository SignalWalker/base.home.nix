inputs @ {
  config,
  pkgs,
  ...
}: {
  imports = config.lib.signal.fs.listFiles ./system;
}
