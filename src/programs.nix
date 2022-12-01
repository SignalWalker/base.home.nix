inputs @ {
  config,
  pkgs,
  lib,
  ...
}: {
  imports = lib.signal.fs.path.listFilePaths ./programs;
  config = {
    home.packages = with pkgs; [
      btop
    ];

    programs.info.enable = true;
  };
}
