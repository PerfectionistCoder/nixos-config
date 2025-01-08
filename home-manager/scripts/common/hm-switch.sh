if [[ $# == 0 ]]; then
  home-manager switch --flake $NIXOS_CONFIG_HOME/#$FLAKE_HOSTNAME
else
  home-manager $*
fi
