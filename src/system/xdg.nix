inputs @ {
  config,
  pkgs,
  lib,
  ...
}: {
  options.xdg.userDirs.templateFile = with lib;
    mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          text = mkOption {type = types.str;};
          target = mkOption {type = types.str;};
        };
      });
      default = {};
    };
  config = {
    home.file =
      lib.mapAttrs'
      (name: file:
        lib.nameValuePair "${config.xdg.userDirs.templates}/${name}" (file
          // {
            target = "${config.xdg.userDirs.templates}/${file.target}";
          }))
      config.xdg.userDirs.templateFile;
    xdg = let
      home = config.home.homeDirectory;
    in {
      enable = true;
      cacheHome = "${home}/.cache";
      configHome = "${home}/.config";
      stateHome = "${home}/.local/state";
      dataHome = "${home}/.local/share";
      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = "${home}/desktop";
        documents = "${home}/documents";
        download = "${home}/downloads";
        music = "${home}/music";
        pictures = "${home}/pictures";
        publicShare = "${home}/public";
        templates = "${home}/templates";
        videos = "${home}/video";
        extraConfig = {
          XDG_PROJECTS_DIR = "${home}/projects";
          XDG_NOTES_DIR = "${home}/notes";
          XDG_BACKUP_DIR = "${home}/backup";
          XDG_SOURCE_DIR = "${home}/src";
          XDG_GAMES_DIR = "${home}/games";
          XDG_BOOKS_DIR = "${home}/books";
        };
      };
    };
  };
}
