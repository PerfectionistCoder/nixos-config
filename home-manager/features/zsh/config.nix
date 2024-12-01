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
+ (optionalString config.custom.features.bat.enable ''
  alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
  alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

  alias man='batman'
  compdef batman='man'
'')
