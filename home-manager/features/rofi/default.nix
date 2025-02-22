{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = import ./config.nix // import ./keybinds.nix;
  };
}
