{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib;
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];
    policies = import ./policies.nix;
  };
}
