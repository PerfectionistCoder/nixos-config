sudo /run/current-system/sw/bin/nix-collect-garbage -d
nix-env --delete-generations old
home-manager expire-generations $(date +%X)