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
    package = inputs.firefox.packages.${pkgs.system}.firefox-bin;
    languagePacks = [ "en-US" ];
    policies = import ./policies.nix;
  };
}
