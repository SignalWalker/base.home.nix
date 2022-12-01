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
  imports = [];
  config = {
    programs.gpg = {
      enable = config.system.isNixOS;
      homedir = "${config.xdg.dataHome}/gnupg";
    };

    systemd.user.sessionVariables = lib.mkIf (!config.programs.gpg.enable) {
      "GNUPGHOME" = config.programs.gpg.homedir;
    };
  };
  meta = {};
}
