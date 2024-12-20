{ lib, config, ... }:
with lib;
with config.custom;
{
  programs.yazi = {
    enable = true;
    settings = import ./settings.nix;
    keymap = import ./keymap.nix;
    theme = import ./theme.nix theme;
    initLua = import ./initLua.nix theme;
  };
  xdg.configFile."yazi/plugins".source = ./plugins;
}
