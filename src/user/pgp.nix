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

  gpg = config.programs.gpg;
  agent = config.services.gpg-agent;
in {
  options = with lib; {};
  disabledModules = [];
  imports = [];
  config = {
    programs.gpg = {
      enable = config.system.isNixOS;
      homedir = "${config.xdg.dataHome}/gnupg";
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;

      enableBashIntegration = true;
      enableFishIntegration = fish.enable;
      enableZshIntegration = zsh.enable;
      enableNushellIntegration = nu.enable;

      defaultCacheTtl = 7200; # 2 hours
      defaultCacheTtlSsh = agent.defaultCacheTtl;
    };

    systemd.user.sessionVariables = lib.mkIf (!config.programs.gpg.enable) {
      "GNUPGHOME" = config.programs.gpg.homedir;
    };
  };
  meta = {};
}
