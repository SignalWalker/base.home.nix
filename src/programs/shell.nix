{
  config,
  pkgs,
  lib,
  ...
}: let
  prg = config.programs;
in {
  imports = lib.signal.fs.path.listFilePaths ./shell;

  config = {
    home.packages = with pkgs; [
      ripgrep
      ripgrep-all
      fd
    ];

    home.shellAliases = {
      ls = "lsd";
      ll = "lsd -l";
      lt = "lsd --tree";
      la = "lsd -a";
      lla = "lsd -la";
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
    };

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = prg.fish.enable;
      enableZshIntegration = prg.zsh.enable;
    };

    programs.bat = {
      enable = true;
    };

    systemd.user.sessionVariables = {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = false; # using a special fancy plugin instead
      enableZshIntegration = prg.zsh.enable;
      defaultCommand = "fd --type f";
      fileWidgetCommand = "fd --type f --hidden --follow --exclude '.git'";
      changeDirWidgetCommand = "fd --type d --hidden --follow --exclude '.git'";
    };

    # command history
    programs.atuin = {
      enable = true;
      settings = {
        db_path = "${config.xdg.dataHome}/atuin/history.db";
        key_path = "${config.xdg.dataHome}/atuin/key";
        session_path = "${config.xdg.dataHome}/atuin/session";
        dialect = "us";
        auto_sync = true;
        update_check = false;
        sync_address = "http://192.168.0.4:8398";
        sync_frequency = "1h";
        search_mode = "fuzzy";
        filter_mode = "global";
        style = "auto";
        exit_mode = "return-original";
        inline_height = 8;
      };
    };
  };
}
