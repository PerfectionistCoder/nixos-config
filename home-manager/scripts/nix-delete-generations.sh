/run/current-system/sw/bin/nix-env --delete-generations old >/dev/null
$HOME/.nix-profile/bin/home-manager expire-generations $(date +%X) >/dev/null
