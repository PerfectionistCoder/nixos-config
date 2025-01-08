if test -z $1; then
	sudo /run/current-system/sw/bin/nix flake update --flake $NIXOS_CONFIG_HOME
else
	sudo /run/current-system/sw/bin/nix flake update $1
fi
