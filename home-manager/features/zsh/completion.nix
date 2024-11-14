''
  fpath=(~/.zsh/completions $fpath)
  autoload -Uz compinit
  compinit -u

  zmodload zsh/complist

  zstyle ':completion:*' use-cache on
  zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

  zstyle ':completion:*' menu select
''
