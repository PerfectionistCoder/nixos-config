{
  env = [
    "GDK_BACKEND,wayland,x11,*"
    "XDG_SESSION_TYPE,wayland"
    "XDG_SESSION_DESKTOP,Hyprland"

    "MAX_WORKSPACE, 5"

    "VOLUME_STEP,2"
    "BRIGHTNESS_STEP, 0.1"
  ];
  "$mod" = "SUPER";
  "$terminal" = "alacritty";
  "$resize_step" = "50";
}
