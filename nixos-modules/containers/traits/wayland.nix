{ userUid, ... }:
{
  bindMounts = {
    waylandDisplay = rec {
      hostPath = "/run/user/${toString userUid}";
      mountPoint = hostPath;
    };
  };
  ephemeral = true;

  config = {
    environment.sessionVariables = {
      WAYLAND_DISPLAY = "wayland-1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_RUNTIME_DIR = "/run/user/${toString userUid}";
      DISPLAY = ":0";
    };
  };
}
