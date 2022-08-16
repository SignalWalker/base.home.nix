inputs @ {
  config,
  pkgs,
  ...
}: {
  imports = config.lib.signal.fs.listFiles ./programs;
  config = {
    home.packages = with pkgs; [
      btop
    ];

    programs.gpg = {
      enable = true;
      homedir = "${config.xdg.configHome}/gnupg";
    };

    programs.info.enable = true;
  };
}
