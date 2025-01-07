FLAKE=$1
shift

sudo /run/current-system/sw/bin/nixos-rebuild switch --flake $NIXOS_CONFIG_HOME/#${FLAKE:-$FLAKE_HOSTNAME} ${@:---impure}
