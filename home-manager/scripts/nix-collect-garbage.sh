if [[ $1 == "--unwrap" ]]; then
	shift
	sudo /run/current-system/sw/bin/nix-collect-garbage $*
else
	sudo /run/current-system/sw/bin/nix-collect-garbage -d
fi
