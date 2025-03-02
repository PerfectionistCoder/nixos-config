{ pkgs, ... }:
{
  programs.extra-container.enable = true;

  networking.nat = {
    enable = true;
    internalInterfaces = [
      "ve-+"
    ];
    externalInterface = "wlp4s0";
    enableIPv6 = true;
  };

  security.polkit = {
    enable = true;
    extraConfig = builtins.readFile ./rules.js;
    debug = true;
  };
  users.groups.machine = { };
}
