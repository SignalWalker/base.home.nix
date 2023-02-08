{
  config,
  pkgs,
  lib,
  ...
}:
with builtins; let
  std = pkgs.lib;
  fish = config.programs.fish;
in {
  options = with lib; {
    programs.fish.pluginSources = mkOption {
      type = types.attrsOf types.path;
      default = {};
    };
  };
  disabledModules = [];
  imports = [];
  config = {
    programs.fish = {
      enable = true;
      plugins = map (name: {
        inherit name;
        src = fish.pluginSources.${name};
      }) (attrNames fish.pluginSources);
    };
  };
  meta = {};
}
