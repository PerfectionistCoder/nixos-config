lib: config:
with lib;
with config.custom.theme;
''
  setopt APPEND_HISTORY
  setopt HIST_SAVE_NO_DUPS
  setopt HIST_FIND_NO_DUPS

  unset zle_bracketed_paste

  export WORDCHARS='._*?'
''
