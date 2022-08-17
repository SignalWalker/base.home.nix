{
  config,
  pkgs,
  lib,
  ...
}: let
  prg = config.programs;
in {
  imports = lib.signal.fs.listFiles ./shell;

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

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = prg.fish.enable;
      enableZshIntegration = prg.zsh.enable;
      defaultCommand = "fd --type f";
      fileWidgetCommand = "fd --type f --hidden --follow --exclude '.git'";
      changeDirWidgetCommand = "fd --type d --hidden --follow --exclude '.git'";
    };
  };
}
