sudo /run/current-system/sw/bin/nix-collect-garbage -d
nix-env --delete-generations old >/dev/null 2&>1 
home-manager expire-generations $(date +%X) >/dev/null 2&>1 
