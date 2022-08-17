{
  config,
  pkgs,
  ...
}:
with builtins; {
  config = {
    home.sessionPath = [];
    home.sessionVariables = config.systemd.user.sessionVariables;
  };
}
