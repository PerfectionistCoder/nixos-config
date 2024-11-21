''
  fpath=($ZDOTDIR/completions $fpath)
  autoload -Uz compinit && compinit 

  zstyle ':completion:*' use-cache on
  zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

  zstyle 'completion:*' matcher-list 'm:{a-z}={A-Za-z}'
  zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
  zstyle ':completion:*' menu no
  setopt GLOBDOTS
  zstyle ':fzf-tab:complete:*' fzf-preview 'ls --color $realpath'

  command -v fzf > /dev/null && eval "$(fzf --zsh)"
''
