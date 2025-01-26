{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ "~/Downloads/amber-d.jxl" ];
      wallpaper = [ "HDMI-A-1,~/Downloads/amber-d.jxl" ];
    };
  };
}
