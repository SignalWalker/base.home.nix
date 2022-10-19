inputs @ {
  config,
  pkgs,
  lib,
  ...
}: {
  imports = lib.signal.fs.path.listFilePaths ./programs;
  config = {
    home.packages = with pkgs; [
      btop
    ];

    programs.gpg = {
      enable = config.system.isNixOS;
      homedir = "${config.xdg.configHome}/gnupg";
    };

    systemd.user.sessionVariables = lib.mkIf (!config.programs.gpg.enable) {
      "GNUPGHOME" = config.programs.gpg.homedir;
    };

    programs.info.enable = true;
  };
}
