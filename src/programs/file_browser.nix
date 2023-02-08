{
  config,
  pkgs,
  lib,
  ...
}:
with builtins; let
  std = pkgs.lib;
in {
  options = with lib; {};
  disabledModules = [];
  imports = lib.signal.fs.path.listFilePaths ./file_browser;
  config = {
    programs.ranger = {
      enable = true;
      settings = {
        draw_borders = "separators";
        unicode_ellipsis = true;
        update_title = true;
      };
    };
    programs.nnn = {};
  };
  meta = {};
}
