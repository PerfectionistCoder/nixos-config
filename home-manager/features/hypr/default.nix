{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with builtins;
with lib;
with config.custom;
{
  imports = [
    ./hypridle.nix
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings =
      import ./env.nix
      // import ./binds.nix lib
      // import ./general.nix theme
      // import ./animations.nix
      // import ./rules.nix lib theme
      // (
        let
          width = 2560;
          height = 1080;
          hz = 60;
        in
        {
          monitor = "HDMI-A-1, ${toString width}x${toString height}@${toString hz}, 0x0, 1";
          exec-once = [
            "eww open mainbar; update-volume; update-mute"
            "hyprctl dispatch movecursor ${toString (width / 2)} ${toString (height / 2)}"
          ];
        }
      );
    extraConfig = import ./config.nix lib;
  };
}
