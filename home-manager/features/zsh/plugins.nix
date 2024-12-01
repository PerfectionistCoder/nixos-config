config: lib:
with lib;
with config.custom.features;
[
  {
    name = "zsh-autosuggestions";
    config = ''
      ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
  
      bindkey '^I' autosuggest-accept
    '';
  }
  {
    name = "zsh-syntax-highlighting";
    config = ''
      ZSH_AUTOSUGGEST_MANUAL_REBIND=ture
      ZSH_AUTOSUGGEST_STRATEGY=(completion)
      ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(accept-line kill-line)
      ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=()
      ZSH_AUTOSUGGEST_EXECUTE_WIDGETS=()
    '';
  }
]
++ optional fzf.enable {
  name = "zsh-fzf-tab";
  file = "share/fzf-tab/fzf-tab.plugin.zsh";
  config = ''
    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:*' prefix ""
    zstyle ':fzf-tab:*' fzf-flags ${concatStringsSep " " fzf.defaultOptions}
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -a $realpath'

    eval "$(fzf --zsh)"
      
    bindkey '^[[Z' fzf-tab-complete
    bindkey '^R' fzf-history-widget
  '';
}
