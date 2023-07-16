{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
in {
  home.packages = with pkgs; [
    vivid
  ];
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableVteIntegration = true;
    # must be false for fzf-tab to work
    enableAutosuggestions = false;
    syntaxHighlighting.enable = true;
    autocd = true;
    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      save = 10000;
      size = 10000;
      share = true;
      extended = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
    shellAliases = config.home.shellAliases;
    plugins = [
      {
        src = pkgs.zsh-fzf-tab.src;
        name = "fzf-tab";
      }
      {
        src = pkgs.zsh-fast-syntax-highlighting.src;
        name = "fast-syntax-highlighting";
      }
      {
        src = pkgs.zsh-autosuggestions.src;
        name = "zsh-autosuggestions";
      }
    ];
    historySubstringSearch = {
      enable = !config.programs.atuin.enable;
      searchUpKey = [
        "$${terminfo[kcuu1]}"
      ];
      searchDownKey = [
        "$${terminfo[kcud1]}"
      ];
    };
    # _fzf_compgen_path() {
    #     fd --hidden --follow --exclude '.git' . "$1"
    # }
    # _fzf_compgen_dir() {
    #     fd --type d --hidden --follow --exclude '.git' . "$1"
    # }
    # export FZF_DEFAULT_COMMAND='${pkgs.fd}/bin/fd --type f'
    defaultKeymap = "viins";
    initExtra = ''
      # export LS_COLORS=$(${pkgs.vivid}/bin/vivid generate gruvbox-dark-hard)

      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -hF --color=always $realpath'
      zstyle ':fzf-tab:complete:z:*' fzf-preview 'lsd -hF --color=always $realpath'

      # bindkey "$${terminfo[kcuu1]}" history-substring-search-up
      # bindkey "$${terminfo[kcud1]}" history-substring-search-down
      # bindkey -M vicmd 'k' history-substring-search-up
      # bindkey -M vicmd 'j' history-substring-search-down

      bindkey "$${terminfo[kdch1]}" delete-char
      bindkey "$${terminfo[khome]}" beginning-of-line
      bindkey "$${terminfo[kend]}" end-of-line
    '';
  };
}
