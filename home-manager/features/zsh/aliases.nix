{
  reload = "source $ZDOTDIR/.zshrc";

  to-nixos = "cd $NIX_CONFIG_HOME";
  nix-fmt = "(to-nixos; nix fmt)";
  nix-clean = "nix-env --delete-generations old; sudo /run/current-system/sw/bin/nix-collect-garbage -d";
  hm-clean = "home-manager expire-generations $(date +%X)";
  nix-clean-boot-entries = "sudo /run/current-system/bin/switch-to-configuration boot";
  nix-update = "sudo /run/current-system/sw/bin/nix flake update --flake $NIX_CONFIG_HOME";

  load-ssh-key = "f() { eval $(ssh-agent -s); ssh-add \"$HOME/.ssh/$1\"; }; f";
}
