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
      p7zip
      unzip
    ];

    programs.info.enable = true;
  };
}
