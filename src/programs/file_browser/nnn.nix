{
  config,
  pkgs,
  lib,
  ...
}:
with builtins; let
  std = pkgs.lib;
  nnn = config.programs.nnn;
in {
  options = with lib; {
    programs.nnn = {};
  };
  disabledModules = [];
  imports = [];
  config = lib.mkIf nnn.enable {};
  meta = {};
}
