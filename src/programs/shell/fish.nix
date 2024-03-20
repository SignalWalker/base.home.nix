{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}:
with builtins; let
  std = pkgs.lib;
  fish = config.programs.fish;
in {
  options = with lib; {
    programs.fish = {
      pluginSources = mkOption {
        type = types.attrsOf types.path;
        default = {};
      };
      themes = mkOption {
        type = types.attrsOf types.path;
        default = {};
      };
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

    xdg.configFile = foldl' (acc: name: let
      theme = fish.themes.${name};
    in
      acc
      // {
        "fish/themes/${name}.theme" = {
          source = theme;
        };
      }) {} (attrNames fish.themes);

    programs.zsh.initExtra = ''
      # if starting zsh in interactive mode and the parent process is not fish, exec fish
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${ZSH_EXECUTION_STRING} ]]
      then
        [[ -o login ]] && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${fish.package}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
  meta = {};
}
