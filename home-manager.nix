{
  config,
  pkgs,
  lib,
  ...
}:
with builtins; let
  std = lib;
in {
  options = {};
  imports = lib.signal.fs.listFiles ./src;
  config = {
    programs.home-manager.enable = true;
    home.enableNixpkgsReleaseCheck = true;
    news.display = "notify";
  };
}
