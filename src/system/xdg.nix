inputs @ {
  config,
  osConfig,
  pkgs,
  lib,
  options,
  ...
}: let
  std = pkgs.lib;
  xdg = config.xdg;
  userDirs = xdg.userDirs;
  nix = osConfig.nix;
in {
  options.xdg = with lib; let
    fileType = config.lib.hm.types.file;
  in {
    userDirs.templateFile = mkOption {
      type = fileType "<varname>xdg.userDirs.templates</varname>" "" config.xdg.userDirs.templates;
      default = {};
    };
    binHome = mkOption {
      type = types.path;
      default = "${config.home.homeDirectory}/.local/bin";
    };
    binFile = mkOption {
      type = fileType "<varname>xdg.binHome</varname>" "" config.xdg.binHome;
      default = {};
    };
  };
  imports = [];
  config = {
    lib.hm.types.file =
      (import "${config.signal.base.homeManagerSrc}/modules/lib/file-type.nix" {
        inherit (config.home) homeDirectory;
        inherit lib pkgs;
      })
      .fileType;
    home.file = lib.mkMerge [
      (std.mapAttrs' (name: file: std.nameValuePair "${xdg.userDirs.templates}/${name}" file) xdg.userDirs.templateFile)
      (std.mapAttrs' (name: file: std.nameValuePair "${xdg.binHome}/${name}" file) xdg.binFile)
    ];
    home.sessionPath = [
      xdg.binHome
    ];
    home.preferXdgDirectories = true;
    xdg = let
      home = config.home.homeDirectory;
    in {
      enable = true;
      cacheHome = "${home}/.cache";
      configHome = "${home}/.config";
      stateHome = "${home}/.local/state";
      dataHome = "${home}/.local/share";
      systemDirs = {
        data =
          if nix.settings.use-xdg-base-directories
          then ["${xdg.stateHome}/nix/profile"]
          else ["${home}/.nix-profile"];
      };
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
          XDG_SCREENSHOTS_DIR = "${userDirs.pictures}/screenshots";
          XDG_WALLPAPERS_DIR = "${userDirs.pictures}/wallpapers";
        };
      };
    };
  };
}
