{
  config,
  pkgs,
  ...
}:
with builtins; {
  programs.starship = let
    prg = config.programs;
  in {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = prg.fish.enable;
    enableIonIntegration = prg.ion.enable;
    enableZshIntegration = prg.zsh.enable;
    settings = {
      add_newline = false;
      right_format = "$time";
      sudo = rec {
        disabled = false;
        symbol = "⚿ ";
        format = "\\[${symbol}\\]";
      };

      time = {
        disabled = false;
        format = "⏱ [$time]($style)";
      };

      username = {
        format = "\\[[$user]($style)\\]";
      };

      status = {
        disabled = false;
      };

      memory_usage = rec {
        disabled = false;
        symbol = " ";
        format = "\\[${symbol}[$ram( | $swap)]($style)\\]";
      };

      directory = {
        truncate_to_repo = false;
        read_only = " ";
        fish_style_pwd_dir_length = 2;
      };

      shell = {
        disabled = false;
        fish_indicator = "";
        zsh_indicator = "↯";
        ion_indicator = "⚝";
        nu_indicator = "ǂ";
      };

      shlvl = {
        # disabled = false;
        symbol = " ";
      };

      battery = {
        display = [
          {
            threshold = 10;
            style = "bold red";
          }
          {
            threshold = 100;
            style = "yellow";
          }
        ];
      };

      character = {
        success_symbol = "[☽](green)";
        error_symbol = "[☽](red)";
        vicmd_symbol = "[☾](green)";
      };

      cmd_duration = {
        format = "\\[[⏱ $duration]($style)\\]";
      };

      ### SPECIFIC

      aws = rec {
        symbol = "  ";
        format = "\\[[${symbol}($profile)(\\($region\\))(\\[$duration\\])]($style)\\]";
      };

      cmake = {
        format = "\\[[$symbol($version)]($style)\\]";
      };

      cobol = {
        format = "\\[[$symbol($version)]($style)\\]";
      };

      conda = rec {
        symbol = " ";
        format = "\\[[${symbol}$environment]($style)\\]";
      };

      crystal = {
        format = "\\[[$symbol($version)]($style)\\]";
      };

      dart = rec {
        symbol = " ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      deno = {
        format = "\\[[$symbol($version)]($style)\\]";
      };

      docker_context = rec {
        symbol = " ";
        format = "\\[[${symbol}$context]($style)\\]";
      };

      dotnet = {
        format = "\\[[$symbol($version)(🎯 $tfm)]($style)\\]";
      };

      elixir = rec {
        symbol = " ";
        format = "\\[[${symbol}($version \\(OTP $otp_version\\))]($style)\\]";
      };

      elm = rec {
        symbol = " ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      erlang = {
        format = "\\[[$symbol($version)]($style)\\]";
      };

      gcloud = {
        format = "\\[[$symbol$account(@$domain)(\\($region\\))]($style)\\]";
      };

      git_branch = rec {
        symbol = " ";
        format = "\\[[${symbol}$branch]($style)\\]";
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style))";
      };

      golang = rec {
        symbol = " ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      helm = {
        format = "\\[[$symbol($version)]($style)\\]";
      };

      hg_branch = rec {
        symbol = " ";
        format = "\\[[${symbol}$branch]($style)\\]";
      };

      java = rec {
        symbol = " ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      julia = rec {
        symbol = " ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      kotlin = {
        format = "\\[[$symbol($version)]($style)\\]";
      };

      kubernetes = {
        format = "\\[[$symbol$context( \\($namespace\\))]($style)\\]";
      };

      lua = {
        format = "\\[[$symbol($version)]($style)\\]";
      };

      nim = rec {
        symbol = " ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      nix_shell = rec {
        symbol = " ";
        format = "\\[[${symbol}$state( \\($name\\))]($style)\\]";
      };

      nodejs = rec {
        symbol = " ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      ocaml = {
        format = "\\[[$symbol($version)(\\($switch_indicator$switch_name\\))]($style)\\]";
      };

      openstack = {
        format = "\\[[$symbol$cloud(\\($project\\))]($style)\\]";
      };

      package = rec {
        symbol = " ";
        format = "\\[[${symbol}$version]($style)\\]";
      };

      perl = rec {
        symbol = " ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      php = rec {
        symbol = " ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      pulumi = {
        format = "\\[[$symbol$stack]($style)\\]";
      };

      purescript = {
        format = "\\[[$symbol($version)]($style)\\]";
      };

      python = rec {
        symbol = " ";
        # format = "\\[[${symbol}${pyenv_prefix}(${version})(\\($virtualenv\\))]($style)\\]"
      };

      red = {
        format = "\\[[$symbol($version)]($style)\\]";
      };

      ruby = rec {
        symbol = " ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      rust = rec {
        symbol = " ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      scala = rec {
        symbol = " ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      swift = rec {
        symbol = "ﯣ ";
        format = "\\[[${symbol}($version)]($style)\\]";
      };

      terraform = {
        format = "\\[[$symbol$workspace]($style)\\]";
      };

      vagrant = {
        format = "\\[[$symbol($version)]($style)\\]";
      };

      vlang = {
        format = "\\[[$symbol($version)]($style)\\]";
      };

      zig = {
        format = "\\[[$symbol($version)]($style)\\]";
      };
    };
  };
}
