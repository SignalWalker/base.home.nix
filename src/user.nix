inputs @ {
  config,
  pkgs,
  profile,
  lib,
  ...
}: {
  options = with lib; {};
  imports = [];
  config = {
    accounts.email.accounts = {
      primary = {
        address = "ashurstwalker@gmail.com";
        flavor = "gmail.com";
        primary = true;
      };
      secondary = {
        address = "protomith@gmail.com";
        flavor = "gmail.com";
      };
      personal = {
        address = "ash@ashwalker.net";
      };
      business = {
        address = "signalgarden@gmail.com";
        flavor = "gmail.com";
      };
    };
  };
}
