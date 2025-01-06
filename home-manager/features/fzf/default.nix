{
  config,
  lib,
  customLib,
  ...
}:
with lib;
let
  color =
    with config.custom.theme;
    "bg:#${background},bg+:#${cursor_line},border:#${border},fg:#${text},fg+:#${text},gutter:#${background},header:#${text},hl:#${text},hl+:#${text},info:#${text},marker:#${primary},preview-bg:#${background},preview-fg:#${text},prompt:#${text},spinner:#${text}";
  bind = "esc:abort,tab:accept,space:toggle";
  commonOptions = [
    "--layout=reverse"
    "--info=inline-right"
    "--no-separator"
    "--preview-window=border-left"
    "--color=${color}"
    "--bind=${bind}"
    "--prompt=:"
    "--no-scrollbar"
    "--pointer="
    "--marker= "
    "--no-mouse"
  ];
  cfg = {
    defaultOptions = commonOptions ++ [ "--height=-1" ];
    fullscreenOption = commonOptions ++ [ "--no-height" ];
  };
in
{
  options = customLib.mkOptionsFrom.set cfg;

  custom.features.fzf = cfg;

  programs.fzf = with config.custom.features.fzf; {
    enable = true;
    defaultOptions = defaultOptions;
    changeDirWidgetOptions = fullscreenOption;
    historyWidgetOptions = fullscreenOption;
  };
}
