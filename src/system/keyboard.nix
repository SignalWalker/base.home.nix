inputs @ {
  config,
  pkgs,
  lib,
  ...
}: {
  # options.home.keyboard = with lib; {
  #   keymap = mkOption (
  #     let
  #       xkbSubmodule = types.submodule ({ config, ... }: {
  #         options = {
  #           keycodes = mkOption { type = keycodeSubmodule; };
  #           types = mkOption { type = typesSubmodule; };
  #           compat = mkOption { type = compatSubmodule; };
  #           symbols = mkOption { type = symbolsSubmodule; };
  #           geometry = mkOption { type = geometrySubmodule; };
  #         };
  #         config = {
  #         };
  #       });
  #     in
  #     {
  #       type = types.nullOr xkbSubmodule;
  #       default = null;
  #     }
  #   );
  # };
  config = let
    cfg = config.home.keyboard;
  in {
    home.keyboard = {
      model = "asus_laptop";
      layout = "us,us";
      variant = ",dvorak";
      options = [
        "caps:hyper"
        "grp:toggle"
        "grp_led:caps"
        "keypad:future"
      ];
    };
    # services.X11.xmodmap = {
    #   enable = true;
    #   settings = ''
    #     clear mod3
    #     clear mod4
    #     add mod3 = Super_L
    #     add mod4 = Hyper_L
    #   '';
    # };
    # services.X11.xkeymap = {
    #     keycodes.include = [ "evdev" "alias(qwerty)" ];
    #     types.include = [ "complete" ];
    #     compat.include = [ "complete" ];
    #     symbols.include = [ "pc" "us" "inet(evdev)" ];
    #     geometry.include = [ "pc(pc104)" ];
    # };
    # systemd.user.services.setxkbmap.Service.ExecStart = concatStringsSep " " [
    #   config.systemd.user.services.setxkbmap.Service.ExecStart
    # ] ++ (map (c: "-compat ${c}") cfg.compats)
    # ++ (std.optionals (cfg.extraConfigFile != null) [ "-config ${cfg.extraConfig}" ]);
  };
}
