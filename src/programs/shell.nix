{
  config,
  pkgs,
  lib,
  ...
}: let
  prg = config.programs;
  fish = prg.fish;
  zsh = prg.zsh;
  ion = prg.ion;
  nu = prg.nushell;
in {
  imports = lib.signal.fs.path.listFilePaths ./shell;

  config = {
    home.packages = with pkgs; [
      rargs
    ];

    programs.fd = {
      enable = true;
    };

    programs.ripgrep = {
      enable = true;
      arguments = [
        "--type-not=lock"
      ];
    };

    home.shellAliases = {
      ls = "eza";
      ll = "eza --long";
      lt = "eza --tree";
      la = "eza --all";
      lla = "eza --long --all";
    };

    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = fish.enable;
      enableZshIntegration = zsh.enable;
      enableIonIntegration = ion.enable;
      enableNushellIntegration = nu.enable;
      git = true;
      icons = true;
      extraOptions = [
        "--sort=extension"
        "--group-directories-first"
        # long view
        "--header"
        "--smart-group"
        "--mounts"
        "--extended"
        "--time-style=+%Y-%m-%d %H:%M"
      ];
    };

    programs.lsd = {
      enable = true;
      enableAliases = false;
      # package = pkgs.lsd;
      settings = {
        classic = false;
        blocks = [
          "permission"
          "user"
          "group"
          "context"
          "size"
          "date"
          "name"
        ];
        color = {
          when = "auto";
          theme = "default";
        };
        date = "+%Y-%m-%d %H:%M:%S";
        icons = {
          when = "auto";
          theme = "fancy";
          separator = " ";
        };
        indicators = true;
        sorting = {
          column = "extension";
          dir-grouping = "first";
        };
        no-symlink = false;
        hyperlink = "auto";
      };
    };

    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = fish.enable;
      enableZshIntegration = zsh.enable;
    };

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = fish.enable;
      enableZshIntegration = zsh.enable;
      enableNushellIntegration = nu.enable;
    };

    programs.bat = {
      enable = true;
    };

    systemd.user.sessionVariables = {
      MANROFFOPT = "-c"; # fix formatting errors with $MANPAGER
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = false; # using a special fancy plugin instead
      enableZshIntegration = zsh.enable;
      defaultCommand = "fd --type f";
      fileWidgetCommand = "fd --type f --hidden --follow --exclude '.git'";
      changeDirWidgetCommand = "fd --type d --hidden --follow --exclude '.git'";
    };

    # command history
    programs.atuin = {
      enable = true; # TODO :: https://github.com/atuinsh/atuin/issues/1661
      enableBashIntegration = true;
      enableFishIntegration = fish.enable;
      enableZshIntegration = zsh.enable;
      enableNushellIntegration = nu.enable;
      settings = {
        db_path = "${config.xdg.dataHome}/atuin/history.db";
        key_path = "${config.xdg.dataHome}/atuin/key";
        session_path = "${config.xdg.dataHome}/atuin/session";
        dialect = "us";
        auto_sync = true;
        update_check = false;
        sync_address = "http://atuin.sync.terra.ashwalker.net";
        sync_frequency = "1h";
        search_mode = "fuzzy";
        search_mode_shell_up_key_binding = "prefix";
        filter_mode = "global";
        filter_mode_shell_up_key_binding = "host";
        style = "auto";
        exit_mode = "return-original";
        inline_height = 8;
        enter_accept = true;
      };
    };
  };
}
