inputs @ {
  config,
  pkgs,
  lib,
  ...
}: let
  email = config.signal.email;
in {
  options.signal.email = with lib; {
    primary = mkOption {
      type = types.attrsOf types.anything;
      readOnly = true;
      default = head (filter (a: a.primary) (attrValues config.accounts.email.accounts));
    };
    git = mkOption {
      type = types.str;
      default = email.primary.address;
      description = "Email address to use when signing git commits.";
    };
    mercurial = mkOption {
      type = types.str;
      default = email.git;
    };
    thunderbird = {
      enable = (mkEnableOption "thunderbird integration") // { default = config.programs.thunderbird.enable; };
    };
  };
  imports = [];
  config = {
    accounts.email.accounts = {
      ashurstwalker = {
        address = "ashurstwalker@gmail.com";
        flavor = "gmail.com";
        primary = true;
        realName = "Ash Walker";
        thunderbird.enable = email.thunderbird.enable;
      };
      protomith = {
        address = "protomith@gmail.com";
        flavor = "gmail.com";
        realName = "Ash";
        thunderbird.enable = email.thunderbird.enable;
      };
      signalwalker = {
        address = "signalwalker@gmail.com";
        flavor = "gmail.com";
        realName = "Ash";
        thunderbird.enable = email.thunderbird.enable;
      };
      ash = {
        address = "ash@ashwalker.net";
        realName = "Ash Walker";
        thunderbird.enable = email.thunderbird.enable;
      };
      # businessGeneral = {
      #   address = "signalgarden@gmail.com";
      #   flavor = "gmail.com";
      #   realName = "Signal Garden";
      #   thunderbird.enable = email.thunderbird.enable;
      # };
      signalgarden = {
        address = "ash@signalgarden.net";
        realName = "Ash Walker";
        thunderbird.enable = email.thunderbird.enable;
      };
    };
  };
}
