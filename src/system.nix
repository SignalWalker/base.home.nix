inputs @ {
  config,
  osConfig,
  pkgs,
  lib,
  ...
}:
with builtins; let
  std = pkgs.lib;
  xdg = config.xdg;
  name = "hm-wipe-history";
in {
  imports = lib.signal.fs.path.listFilePaths ./system;
  config = {
    systemd.user.timers.${name} = {
      Unit = {
        Description = "Periodically wipe old home-manager generations";
        PartOf = ["default.target"];
      };
      Install = {
        WantedBy = ["default.target"];
      };
      Timer = {
        OnCalendar = "daily";
        Persistent = true;
        RandomizedDelaySec = "1h";
        Unit = "${name}.service";
      };
    };

    systemd.user.services.${name} = {
      Unit = {
        Description = "Wipe home-manager generations older than 7 days";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${osConfig.nix.package}/bin/nix profile wipe-history --profile ${xdg.stateHome}/nix/profiles/home-manager --older-than 7d";
      };
    };
  };
}
