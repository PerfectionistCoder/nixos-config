''
  fpath=($ZDOTDIR/completions $fpath)
  autoload -Uz compinit && compinit

  zstyle ':completion:*' use-cache on
  zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

  setopt GLOBDOTS
  zstyle 'completion:*' matcher-list 'm:{a-z}={A-Za-z}'
''
