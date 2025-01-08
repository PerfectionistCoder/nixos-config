SHELL=${1:?'Missing flake shell name'}
shift

nix develop $NIXOS_CONFIG_HOME#$SHELL ${@:---command zsh}
