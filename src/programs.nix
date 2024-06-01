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
      procs
      du-dust
      calc
      killall
    ];

    programs.info.enable = true;
  };
}
