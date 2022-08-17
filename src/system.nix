inputs @ {
  config,
  pkgs,
  lib,
  ...
}: {
  imports = lib.signal.fs.listFiles ./system;
}
