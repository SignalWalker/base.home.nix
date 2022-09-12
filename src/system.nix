inputs @ {
  config,
  pkgs,
  lib,
  ...
}: {
  imports = lib.signal.fs.path.listFilePaths ./system;
}
