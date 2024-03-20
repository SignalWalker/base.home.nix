{
  config,
  pkgs,
  lib,
  ...
}:
with builtins; let
  std = pkgs.lib;
  ranger = config.programs.ranger;
in {
  options = with lib; {
    # programs.ranger = {
    #   enable = mkEnableOption "ranger file browser";
    #   package = mkPackageOption pkgs "ranger" {};
    #   settings = mkOption {
    #     type = types.submoduleWith {
    #       modules = [
    #         ({
    #           config,
    #           lib,
    #           ...
    #         }: {
    #           freeformType = with lib; types.attrsOf types.anything;
    #           options = with lib; {};
    #         })
    #       ];
    #     };
    #   };
    #   extraConfig = mkOption {
    #     type = types.lines;
    #     default = "";
    #   };
    # };
  };
  disabledModules = [];
  imports = [];
  config = lib.mkIf ranger.enable {
    # home.packages = [ranger.package];
    # xdg.configFile."ranger/rc.conf" = {
    #   text = let
    #     valToStr = val:
    #       if isBool val
    #       then
    #         (
    #           if val
    #           then "true"
    #           else "false"
    #         )
    #       else (toString val);
    #   in
    #     std.concatStringsSep "\n" (
    #       (map (key: "set ${key} ${valToStr ranger.settings.${key}}") (attrNames ranger.settings))
    #       ++ [ranger.extraConfig]
    #     );
    # };
  };
  meta = {};
}
