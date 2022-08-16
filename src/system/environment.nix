{
  config,
  pkgs,
  ...
}:
with builtins; {
  config = {
    home.sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];
    home.sessionVariables = config.systemd.user.sessionVariables;
  };
}
