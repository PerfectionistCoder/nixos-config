{ lib, pkgs, ... }:
let
  pkg = pkgs.callPackage ./package.nix { };
in
{
  home.packages = [ pkg ];

  systemd.user.services = {
    wl-nightlight = {
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        After = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = lib.getExe pkg;
      };
    };
  };
}
