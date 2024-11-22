SHELL=${1:?'Missing flake shell name'}
shift

nix develop $NIX_CONFIG_HOME#$SHELL ${@:---command zsh}