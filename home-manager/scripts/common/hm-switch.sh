FLAKE=$1
shift

home-manager switch --flake $NIXOS_CONFIG_HOME/#${FLAKE:-$FLAKE_HOSTNAME} $@
