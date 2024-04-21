{
  config,
  pkgs,
  lib,
  ...
}:
with builtins; let
  std = pkgs.lib;

  fish = config.programs.fish;
  zsh = config.programs.zsh;
  nu = config.programs.nushell;
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
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = fish.enable;
      enableNushellIntegration = nu.enable;
      enableZshIntegration = zsh.enable;
    };
  };
  meta = {};
}
