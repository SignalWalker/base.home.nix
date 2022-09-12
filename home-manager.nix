{
  config,
  pkgs,
  lib,
  ...
}:
with builtins; let
  std = lib;
in {
  options = with lib; {
    system.isNixOS = (mkEnableOption "allows configuration specific to NixOS systems") // {default = true;};
    signal.base.homeManagerSrc = mkOption {
      type = types.attrsOf types.anything;
    };
  };
  imports = lib.signal.fs.path.listFilePaths ./src;
  config = {
    programs.home-manager.enable = true;
    home.enableNixpkgsReleaseCheck = true;
    news.display = "notify";
  };
}
