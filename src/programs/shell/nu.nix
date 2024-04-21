{
  config,
  pkgs,
  lib,
  ...
}:
with builtins; let
  std = pkgs.lib;

  nu = config.programs.nushell;
in {
  options = with lib; {};
  disabledModules = [];
  imports = [];
  config = {
    programs.nushell = {
      enable = true;
    };
  };
  meta = {};
}
