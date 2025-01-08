if [[ $1 == "--raw" ]]; then
  shift
  sudo /run/current-system/sw/bin/nixos-rebuild $*
else
  cmd=$1
  shift
  sudo /run/current-system/sw/bin/nixos-rebuild ${cmd:-test} --flake $NIXOS_CONFIG_HOME/#$FLAKE_HOSTNAME --impure $*
fi
