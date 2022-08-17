inputs @ {
  config,
  pkgs,
  lib,
  ...
}: let
  xcfg = config.xdg;
in {
  options.xdg = with lib; let
    fileType = config.lib.fileType;
  in {
    userDirs.templateFile = mkOption {
      type = fileType "<varname>xdg.userDirs.templates</varname>" config.xdg.userDirs.templates;
      default = {};
    };
    binHome = mkOption {
      type = types.path;
      default = "${config.home.homeDirectory}/.local/bin";
    };
    binFile = mkOption {
      type = fileType "<varname>xdg.binHome</varname>" config.xdg.binHome;
      default = {};
    };
  };
  config = {
    home.file = lib.mkMerge [
      (lib.mapAttrs' (name: file: lib.nameValuePair "${xcfg.userDirs.templates}/${name}" file) xcfg.userDirs.templateFile)
      (lib.mapAttrs' (name: file: lib.nameValuePair "${xcfg.binHome}/${name}" file) xcfg.binFile)
    ];
    home.sessionPath = [
      xcfg.binHome
    ];
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
