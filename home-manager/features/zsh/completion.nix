config: lib:
with lib;
with config.custom.features.fzf;
''
  fpath=($ZDOTDIR/completions $fpath)
  autoload -Uz compinit && compinit

  zstyle ':completion:*' use-cache on
  zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

  setopt GLOBDOTS
  zstyle 'completion:*' matcher-list 'm:{a-z}={A-Za-z}'

  zstyle ':completion:*' menu no
  zstyle ':fzf-tab:*' prefix ""
''
+ optionalString enable ''
  zstyle ':fzf-tab:*' fzf-flags ${concatStringsSep " " defaultOptions}
  zstyle ':fzf-tab:complete:cd:*' fzf-flags ${concatStringsSep " " fullscreenOption}''
+ ''
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -a $realpath'

  command -v fzf > /dev/null && eval "$(fzf --zsh)"
''
