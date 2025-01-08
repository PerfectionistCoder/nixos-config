if [[ $1 == "--raw" ]]; then
  shift
  sudo /run/current-system/sw/bin/nix-collect-garbage $*
else
  sudo /run/current-system/sw/bin/nix-collect-garbage -d
  nix-env --delete-generations old 2 >/dev/null &>1
  home-manager expire-generations $(date +%X) 2 >/dev/null &>1
fi
